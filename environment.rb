APP_ROOT = File.expand_path(File.dirname(__FILE__))
puts "APP_ROOT: #{APP_ROOT}"

Dir.glob("./models/*.rb") { |model_file|  
  require(model_file)
}