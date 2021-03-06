RSpec.configure do |config|
  config.include(ChefSpec::API)
  config.include(ChefSpec::Macros)

  config.after(:each) do
    ChefSpec::Stubs::CommandRegistry.reset!
    ChefSpec::Stubs::DataBagRegistry.reset!
    ChefSpec::Stubs::DataBagItemRegistry.reset!
    ChefSpec::Stubs::SearchRegistry.reset!
  end

  config.add_setting :berkshelf_options, default: {}
  config.add_setting :cookbook_path
  config.add_setting :role_path
  config.add_setting :environment_path
  config.add_setting :file_cache_path
  config.add_setting :log_level, default: :warn
  config.add_setting :path
  config.add_setting :platform
  config.add_setting :version

  # Sometimes we need a constant location to use for the file_cache_path and
  # initializing it here ensures it is available later if needed
  config.class::FILE_CACHE_PATH = Dir.mktmpdir
  at_exit { FileUtils.rm_rf(config.class::FILE_CACHE_PATH) }
end
