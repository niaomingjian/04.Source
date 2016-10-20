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
  
  def self.main(destRootPath, srcRootPath, backupPath)
    
    dateTimeStr = Time.now.strftime("%Y%m%d%H%M%S")

    puts "==Start :get entire files=="
    
    # get destination files
    destDF = DirFile.new
    destDF.getDirFile(destRootPath)
    
    # get source files 
    srcDF = DirFile.new
    srcDF.getDirFile(srcRootPath)
    
    backupPath = "#{backupPath}\\#{dateTimeStr}"
    
    puts "==End :get entire files=="
    
    puts "==Start :generate updateversion=="

    # generate updateversion
    updateFile = UpdateFile.new(destDF.filesList, srcDF.filesList, destRootPath, srcRootPath, backupPath)
    logList = updateFile.updateFile
    
    puts "==End :generate updateversion=="
    
    puts "==Start :output operation logs=="
    # output operation logs
    updateFile.createDirectory(backupPath)
    CSV.open("#{backupPath}\\log_#{dateTimeStr}.csv", "w") do |csv|
      csv << ["No", "Path", "Backup Path", "File Name", "Update Time(Old File)", "Update Time(New File)", "Operation Type"]
      logList.each do |item|
        csv << item  
      end
    end

    puts "==End :output operation logs=="
    
  end
end

destRootPath = "F:\\test\\test_old"
srcRootPath = "F:\\test\\test_new"
backupPath = "F:\\test"
    
UpdateVersion.main(destRootPath, srcRootPath, backupPath)
