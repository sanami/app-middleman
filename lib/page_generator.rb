class PageGenerator < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
    puts 'PageGenerator#initialize'
  end

  def after_configuration
    puts 'PageGenerator#after_configuration'

    ["tom", "dick", "harry"].each do |name|
      app.proxy "/#{name}.html", "/page.html", :locals => { :person_name => name }, :ignore => true
    end
  end

  #def manipulate_resource_list(resources)
  #  puts 'PageGenerator#manipulate_resource_list'
  #end
end

::Middleman::Extensions.register(:page_generator, PageGenerator)
