require 'mail'

module MailLib

  def self.included(base)
    self.setup
  end

  def self.setup
    config = YAML::load File.open(File.expand_path('../server.yml', File.dirname(__FILE__) ) )
    Mail.defaults do
      retriever_method config['server_type'], :address    => config['server'],
                                              :port       => config['port'],
                                              :user_name  => config['user_name'],
                                              :password   => config['password'],
                                              :enable_ssl => config['enable_ssl']
    end
  end

end