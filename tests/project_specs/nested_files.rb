require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Deris::Project do

  let(:output) { File.join(File.dirname(__FILE__), '..', '..', 'output') }
  let(:examples) { File.join(File.dirname(__FILE__), '..', 'examples') }

  context 'with nested templates' do
    
    let(:project) { Deris::Project.new(File.join(examples, 'project')) }
    let(:morrisons_directory) { File.join(output, 'morrisons') }
    let(:morrisons_file) { File.join(output, 'morrisons.html') }
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
    
    it 'should have a relative link to "index.html" in "morrisons.html"' do
      File.read(morrisons_file).should include("href='index.html'")
    end
    
    it 'should have a relative link to "index.html" in "bread.html"' do
      File.read(bread_file).should include("href='../index.html'")
    end
  
  end  
  
end
