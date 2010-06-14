module Deris

  class File
    
    attr_reader :name
    
    def initialize(name = 'index', partials = {}, depth = nil)
      @name = name
      @partials = partials
      @depth = depth || 0
    end
    
    def write(directory)
      FileUtils.mkdir(directory) unless ::File.exist? directory
      output_path = ::File.join(directory, "#{@name}.html")
      ::File.open(output_path, 'w+') do |file|
        file.write render
      end
    end
    
    def render(template = nil)
      if template.nil?
        template = @partials[:layout]
      else
        template = ::File.new(template).read if ::File.exist?(template)
      end
      haml_engine = Haml::Engine.new(template)
      haml_engine.render(self)
    end
    
    def partial(template)
      if template.is_a? Symbol
        template = @partials[template] || ''
      end
      render(template)
    end
    
    def url(path)
      sections = []
      @depth.times do
        sections << '..'
      end
      sections << path
      
      sections.join('/')
    end
    
  end

end
