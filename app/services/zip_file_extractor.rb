require 'zip'

class ZipFileExtractor

  OUTPUT_PATH = File.join('public', 'vinsol_spree_themes')
  IGNORED_FILES_REGEX = /\/(\.|__)/
  VIDEO_FILE_REGEX = /mp4/

  attr_reader :file_path, :theme

  def initialize(file_path, theme)
    @file_path = file_path
    @theme = theme
  end

  def extract
    FileUtils.mkdir_p(OUTPUT_PATH)
    parse_file
  end

  private

    def parse_file
      Zip::File.open(file_path) do |zip_file|
        zip_file.each do |file|
          ## [::NASTY HACK::]
          ## For some zipfiles(including downloaded zip from github),
          ## whole folder is extracted instead of files withing folder
          ## so files extracted to output path is invalid.
          temp_path = "#{ theme.name }/"
          next if file.name == temp_path
          filename = (file.name.include? temp_path) ? file.name.sub(temp_path, '') : file.name

          filepath = File.join(output_path, filename)
          next if filepath =~ IGNORED_FILES_REGEX
          unless File.exist?(filepath)
            FileUtils::mkdir_p(File.dirname(filepath))
            zip_file.extract(file, filepath)
          end
          generate_template(filepath) if File.file?(filepath) && !(file.name =~ VIDEO_FILE_REGEX)
        end
      end
    end

    def output_path
      @output_path ||= File.join(OUTPUT_PATH, file_name)
    end

    def file_name
      @file_name ||= File.basename(file_path, file_extension)
    end

    def file_extension
      File.extname(file_path)
    end

    def generate_template(filepath)
      TemplateGeneratorService.new(filepath, theme).generate
    end

end
