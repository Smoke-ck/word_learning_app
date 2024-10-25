# frozen_string_literal: true
require 'roo'

class BulkUploadWordsService
  class << self
    def call(file)
      @filename = file.original_filename

      case File.extname(@filename)
      when '.xlsx', '.xlsm'
        xlsx_upload(file)
      else
        raise "Unsupported file format. Please upload .xlsx files."
      end
    end

    def xlsx_upload(file)
      sheet = Roo::Excelx.new(file.path)
      bulk_upload_job(sheet)
    end

    def bulk_upload_job(array)
      array.each_row_streaming(offset: 1) do |row|
        break if row[0].cell_value.nil?

        Word.create(name: row[0].cell_value, definition: row[1].cell_value)
      end
    end
  end
end
