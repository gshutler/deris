require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Deris::Directory do

  let(:examples) { File.join(File.dirname(__FILE__), '..', 'examples') }

  context 'with content defined by convention' do
  
    let(:directory) { Deris::Directory.new(File.join(examples, 'contentconvention')) }
    let(:partials) { directory.partials_hash }
        
    it 'should have the same value for :content as :contentconvention' do
      partials[:content].should_not be_nil
      partials[:content].should == partials[:contentconvention]
    end

  end
  
  context 'with content defined and a partial matching the convention' do
    
    let(:directory) { Deris::Directory.new(File.join(examples, 'contentconventionclash')) }
    let(:partials) { directory.partials_hash }
    
    it 'should not overwrite the :content partial with the partial matching the convention' do
      partials[:content].should_not == partials[:contentconventionclash]
    end
    
  end

end
