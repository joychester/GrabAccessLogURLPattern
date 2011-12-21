class GrabAccessURI

  def initialize
    @@array = [];
    @@index = 0;
  end
 

  def extract_pattern_file(filename)

     @before = Time.now.to_f

     f = File.new(filename)
     f.each { |line|

     begin

      a1 = line.split(/\s/);
      uri_matcher = a1[6];

	#Get URL which include /t/... pattern for example
      if uri_matcher =~ /\/t\//
      	#remove the UUID within URL, such as 122ttta-bbb66s7-hh765ss-88uiuj-a89hh
        uri_matcher.gsub!(/(\w+(-\w+)+)/, "");
        if !@@array.include?(uri_matcher)
        @@array[@@index] = uri_matcher
        @@index = @@index +1;
        end
      end

     #catch exception
     rescue => e
        p e.message
     end

    }
    puts Time.now.to_f - @before
    puts f.size

    ensure
      f.close unless f.nil?;


    return @@array;
  end

  def extract_pattern_dir(dir)

    @p1 = Time.now.to_f

    #walk through a directory
    if File.directory?(dir)

      #Traversing all the file within the directory and call extract_pattern_file
      Dir.foreach(dir) { |file_name|

		#Processing all the *.log files under this dir
        if file_name =~ /\.log/
          puts path = dir + "#{file_name}"
          extract_pattern_file(path);
        end
      }
    end

    puts "Total processing time:"
    puts Time.now.to_f - @p1
    
    return @@array
  end
end

geturi = GrabAccessURI.new;
puts geturi.extract_pattern_dir("D:\\GWT_automation\\apacheweb01\\");