require "fileutils"

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
  
  def initialize(oldFilesList, newFilesList, oldRootPath, newRootPath, backpath)
    @oldPath = oldRootPath
    @newPath = newRootPath
    @backpath = backpath + "\\" + Time.now.strftime("%Y%m%d%H%M%S")
    @oldFilesList = oldFilesList
    @newFilesList = newFilesList
  end
  
  def updateFile
    @newFilesList.each do |newFile|
      selected = @oldFilesList.select do |v|
                   v.path[@oldPath.length...v.path.length] == newFile.path[@newPath.length...newFile.path.length] && v.fileName == newFile.fileName 
                 end
      if selected!=nil && !selected.empty?
        
        if selected[0].updateTime < newFile.updateTime
          path = @backpath + selected[0].path[@oldPath.length...selected[0].path.length]
          createDirectory(path)
          # back up
          FileUtils.cp("#{selected[0].path}\\#{selected[0].fileName}", "#{path}\\#{selected[0].fileName}", :preserve => true)
          # update
          FileUtils.cp("#{newFile.path}\\#{newFile.fileName}", "#{selected[0].path}\\#{selected[0].fileName}", {:preserve => true, :verbose => true})
        end
      else
        
        path = @oldPath + newFile.path[@newPath.length...newFile.path.length]
        createDirectory(path)
        # update
        FileUtils.cp("#{newFile.path}\\#{newFile.fileName}", "#{path}\\#{newFile.fileName}", {:preserve => true, :verbose => true})
      end
    end
  end
  
  def createDirectory(path)
    unless File.directory?(path) then
      dir = File.dirname(path)
      createDirectory(dir)
      Dir.mkdir(path)
    end
  end
  
  private :createDirectory
end

class UpdateVersion
  def self.main
    oldRootPath = "F:\\test\\test_old"
    newRootPath = "F:\\test\\test_new"
    
    oldDF = DirFile.new
    oldDF.getDirFile(oldRootPath)
    
    newDF = DirFile.new
    newDF.getDirFile(newRootPath)
    
    backpath = "F:\\test"
    
    updateFile = UpdateFile.new(oldDF.filesList, newDF.filesList, oldRootPath, newRootPath, backpath)
    updateFile.updateFile

  end
end

UpdateVersion.main






