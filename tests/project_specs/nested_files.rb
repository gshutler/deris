require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Deris::Project do

  let(:output) { File.join(File.dirname(__FILE__), '..', '..', 'output') }
  let(:examples) { File.join(File.dirname(__FILE__), '..', 'examples') }

  context 'with nested templates' do
    
    let(:project) { Deris::Project.new(File.join(examples, 'project')) }
    let(:morrisons_directory) { File.join(output, 'morrisons') }
    let(:bread_file) { File.join(morrisons_directory, 'bread.html') }
    
    before do
      project.write(output)
    end

    it 'should create the morrisons directory' do
      File.exist?(morrisons_directory).should be_true
    end
    
    it 'should create a file called "bread.html" in the morrisons directory' do
      File.exist?(bread_file).should be_true
    end
    
    it 'should have the phrase "Freshly baked in store, every day" in "bread.html"' do
      File.read(bread_file).should =~ /Freshly baked in store, every day/
    end
  
  end  
  
end
