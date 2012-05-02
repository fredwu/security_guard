module SecurityGuard
  class Sequences
    include Concerns::Initializable
    include Concerns::InputToOutput

    initializable :input_folder, :output_folder

    def process
      input_to_output :input   => input_folder,
                      :output  => output_folder,
                      :process => :prepend_sequencial_numbers
    end

    private

    def prepend_sequencial_numbers(data)
      data_with_sequences = []
      data.each_with_index do |array, index|
        data_with_sequences[index] = []
        array.each_with_index do |entry, i|
          data_with_sequences[index] << "#{i}, #{entry}"
        end
      end
      data_with_sequences
    end
  end
end