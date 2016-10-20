require "fileutils"
require "csv"

class FileInfo
  attr_accessor  :path, :fileName, :ext, :updateTime
end

class DirFile
  attr_accessor :folderList, :filesList
  def initialize
    @folderList = Array.new
    @filesList = Array.new
  end

  def getDirFile(path)
    # folder
    if File.directory?(path) then
      @folderList << path
      dir = Dir.open(path)
      while name = dir.read
        next if name == "."
        next if name == ".."
        getDirFile("#{path}\\#{name}")
      end
    dir.close
    else
    # file
      fileInfo = FileInfo.new
      fileInfo.path = File.dirname(path)
      fileInfo.fileName = File.basename(path)
      fileInfo.ext = File.extname(path)
      fileInfo.updateTime = File.mtime(path)
    @filesList << fileInfo
    end
  end
end

class RubyProperties
  attr_accessor :file, :properties
  def initialize(file)
    @file = file
    @properties = {}

    begin
      IO.foreach(file) do |line|
        @properties[$1.strip] = $2.strip if line =~ /^([^=]*)=(.*?)(\s*#.*)?$/
      end
    rescue
    end
  end

  def to_s
    output = "File name #{@file}\n"
    @properties.each { |key, value| output += " #{key} = #{value}\n" }
    output
  end

  def add(key, value = nil)
    return unless key.length > 0
    @properties[key] = value
  end

  def remove(key)
    return unless key.length > 0
    @properties.delete(key)
  end

  def save
    file = File.new(@file, "w+")
    @properties.each { |key, value| file.puts "#{key}=#{value}\n" }
    file.close
  end
end

class UpdateFile
  def initialize(destFilesList, srcFilesList, destRootPath, srcRootPath, backupPath)
    @destRootPath = destRootPath
    @srcRootPath = srcRootPath
    @backupPath = backupPath
    @destFilesList = destFilesList
    @srcFilesList = srcFilesList
  end

  def updateFile
    count = 1
    logList = []
    @srcFilesList.each do |srcFile|
      selected = @destFilesList.select do |v|
        v.path[@destRootPath.length...v.path.length] == srcFile.path[@srcRootPath.length...srcFile.path.length] && v.fileName == srcFile.fileName
      end
      if selected!=nil && !selected.empty?
        destFile = selected[0]
        if destFile.updateTime < srcFile.updateTime

          backupPath = @backupPath + destFile.path[File.dirname(@destRootPath).length...destFile.path.length]

          createDirectory(backupPath)
          # back up
          FileUtils.cp("#{destFile.path}\\#{destFile.fileName}", "#{backupPath}\\#{destFile.fileName}", :preserve => true)
          # update
          FileUtils.cp("#{srcFile.path}\\#{srcFile.fileName}", "#{destFile.path}\\#{destFile.fileName}", {:preserve => true})

          log = [count, destFile.path, backupPath, destFile.fileName, destFile.updateTime, srcFile.updateTime, "M(modify)"]
        count = count + 1
        logList << log

        end
      else
        destPath = @destRootPath + srcFile.path[@srcRootPath.length...srcFile.path.length]
        createDirectory(destPath)
        # update
        FileUtils.cp("#{srcFile.path}\\#{srcFile.fileName}", "#{destPath}\\#{srcFile.fileName}", {:preserve => true})

        log = [count, destPath, nil, srcFile.fileName, nil, srcFile.updateTime, "N(new)"]
      count = count + 1
      logList << log
      end
    end
    logList
  end

  def createDirectory(path)
    unless File.directory?(path) then
      dir = File.dirname(path)
      createDirectory(dir)
      Dir.mkdir(path)
    end
  end

end

class UpdateVersion
  def self.main

    time_S = Time.now
    dateTimeStr = Time.now.strftime("%Y%m%d%H%M%S")

    properties = RubyProperties.new("system.properties")
    destRootPath = properties.properties["destRootPath"]
    srcRootPath = properties.properties["srcRootPath"]
    backupPath = properties.properties["backupPath"]

    puts "①.Start :get entire files=>>>>>"

    # get destination files
    destDF = DirFile.new
    destDF.getDirFile(destRootPath)

    # get source files
    srcDF = DirFile.new
    srcDF.getDirFile(srcRootPath)

    backupPath = "#{backupPath}\\#{dateTimeStr}"

    puts "<<<<<=End :get entire files", "\n"

    puts "②.Start :generate updateversion=>>>>>"

    # generate updateversion
    updateFile = UpdateFile.new(destDF.filesList, srcDF.filesList, destRootPath, srcRootPath, backupPath)
    logList = updateFile.updateFile

    puts "<<<<<=End :generate updateversion", "\n"

    puts "③.Start :output operation logs=>>>>>"
    # output operation logs
    updateFile.createDirectory(backupPath)
    CSV.open("#{backupPath}\\log_#{dateTimeStr}.csv", "w") do |csv|
      csv << ["No", "Path", "Backup Path", "File Name", "Update Time(Old File)", "Update Time(New File)", "Operation Type"]
      logList.each do |item|
        csv << item
      end
    end

    puts "<<<<<=End :output operation logs", "\n"

    time_E = Time.now

    puts "Completed. Elapse #{time_E - time_S} s"

  end
end

UpdateVersion.main
