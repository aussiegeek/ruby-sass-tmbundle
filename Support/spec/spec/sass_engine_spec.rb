require File.join(File.dirname(__FILE__), '../spec_helper')

describe SassEngine do
  before(:each) do
    @filename = File.expand_path(File.join(File.dirname(__FILE__), "../../fixtures", "valid_with_options.sass"))
    @output_filename = "output.css"
    @preview_filename = "preview.html"
    @flags = "-s"
    
    @sass_engine = SassEngine.new(@filename)
  end
  
  describe "execution" do
    before(:each) do
      Kernel.stub!(:system).and_return(true)
      
      @status = mock("process status", :exitstatus => 0)
      @sass_engine.stub!(:process_status).and_return(@status)
    end
    
    it "should pipe the output to the engine" do
      #expects
      Kernel.should_receive(:system).with(/#@filename.*sass.*#@flags.*#@output_filename/)
      #when
      @sass_engine.execute!
    end
    
    it "should open the preview file if there was no error" do
      #expects
      Kernel.should_receive(:system).with(/open -g.*#@preview_filename/)
      #when
      @sass_engine.execute!
    end
  end  
  
  describe "filenames" do
    it "should require a filename" do
      lambda { SassEngine.new }.should raise_error
    end
  end
end