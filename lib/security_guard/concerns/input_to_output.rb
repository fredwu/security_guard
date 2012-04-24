module SecurityGuard
  module Concerns
    module InputToOutput
      def input_to_output(args)
        input_data, filenames = read_data_from(args[:input])

        output_data = send(args[:process], input_data)

        write_data_to args[:output],
                      :output_data => output_data,
                      :filenames   => filenames
      end

      private

      def read_data_from(folder)
        files = Dir["#{folder}/*"].sort

        raise Exception.new('Input folder is invalid or is empty.') if files.empty?

        input_data = []
        filenames  = []

        files.each do |file|
          input_data << File.readlines(file).map{ |line| line.downcase.strip }
          filenames  << File.basename(file)
        end

        [input_data, filenames]
      end

      def write_data_to(folder, opts)
        opts[:output_data].each_with_index do |array, index|
          File.open("#{folder}/#{opts[:filenames][index]}", 'w') do |f|
            f.puts array
          end
        end
      end
    end
  end
end