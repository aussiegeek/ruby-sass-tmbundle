class SassEngine
  def initialize(filename)
    raise "You must supply a filename to compile." unless filename
    @filename = filename
  end
  
  def execute!
    compile!
    preview!
  end
  
  
private
  def compile!
    command = options.empty? ? "cat" : "tail -n +2"
    Kernel.system("#{command} #{escape(@filename)} | sass #{flags} -s > #{escape(output_filename)}")
  end
  
  def preview!
    Kernel.system("open -g #{escape(preview_filename)}") if process_status.exitstatus.zero? && preview_filename
  end
  
  def escape(s)
    "\"#{s.gsub('"', '\"')}\""
  end
  
  def process_status
    $?
  end
  
  
  def options
    return {} unless File.file?(@filename)
    first_line = File.open(@filename) {|f| f.readline unless f.eof} || ''
    return {} unless first_line.match(/\s*\/\/\s*(.+:.+)/)
    
    $1.split(',').inject({}) do |hash, pair|
      k,v = pair.split(':')
      hash[k.strip.to_sym] = v.strip if k && v
      hash
    end
  end
  alias :options_no_memo :options
  def options; @options ||= options_no_memo end
  
  def type
    @type ||= @filename[/.+\.(.+)/,1].to_sym
  end
  
  def flags
    options[:flags]
  end
  
  def output_filename
    @output_filename ||= options[:output] || (@filename[/(.*)\.#{type}/,1] + ".css")
  end
  
  def preview_filename
    return if options[:preview] == "none"
    @preview_filename ||= File.join(File.split(@filename)[0], options[:preview]) if options[:preview]
  end
end