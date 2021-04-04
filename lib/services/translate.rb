module Services
  class Translate
    RU = { 'а' => 'a', 'б' => 'b', 'в' => 'v', 'г' => 'g', 'д' => 'd', \
    'е' => 'e', 'ё' => 'e', 'ж' => 'j', 'з' => 'z', 'и' => 'i', \
    'к' => 'k', 'л' => 'l', 'м' => 'm', 'н' => 'n', 'о' => 'o', \
    'п' => 'p', 'р' => 'r', 'с' => 's', 'т' => 't', 'у' => 'u', \
    'ф' => 'f', 'х' => 'h', 'ц' => 'c', 'ч' => 'ch', 'ш' => 'sh', \
    'щ' => 'shch', 'ы' => 'y', 'э' => 'e', 'ю' => 'u', 'я' => 'ya', \
    'й' => 'i', 'ъ' => '', 'ь' => ''}.freeze

    def self.cyr_to_lat(str)
      identifier = ''

      str.downcase.each_char do |char|
        identifier += RU.key?(char) ? RU[char] : char
      end

      identifier.gsub!(/[^a-z0-9_]+/, '_')
      identifier.gsub(/^[-_]*|[-_]*$/, '')
    end
  end
end