module SecurityGuard
  class Deduplication
    include Concerns::Initializable
    include Concerns::InputToOutput

    initializable :input_folder, :output_folder

    def process
      input_to_output :input   => input_folder,
                      :output  => output_folder,
                      :process => :dedupe
    end

    private

    def dedupe(data)
      deduped_data = []

      # start from the lowest array (in terms of dedupe priority)
      data.reverse!
      data_original = data.clone
      data_original.each do |array|
        data.shift
        deduped_data << _deduped_multi(array, data)
      end

      # the top array doesn't need to be compared, just needs to be unique
      deduped_data.last.uniq!
      deduped_data.reverse
    end

    def _deduped_multi(target, others)
      others.each do |array|
        target = _deduped(target, array)
      end
      target
    end

    def _deduped(target, other)
      (target - other & target).uniq
    end
  end
end
