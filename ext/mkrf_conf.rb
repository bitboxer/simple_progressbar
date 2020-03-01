require 'rbconfig'
require 'rubygems/dependency_installer.rb'

inst = Gem::DependencyInstaller.new
begin
  inst.install "win32console" if RbConfig::CONFIG['host_os'] =~ /win32|w32|mingw/
rescue
  exit(1)
end

f = File.open(File.join(File.dirname(__FILE__), "Rakefile"), "w")
f.write("task :default\n")
f.close
