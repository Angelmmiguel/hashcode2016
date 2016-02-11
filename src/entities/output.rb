class Output
  @commands = []

  def self.add_command(str)
    @commands << str
  end

  def self.bulk_file(path)
    File.open(path, 'w') { |file| file.write(@commands.join("\n")) }
  end
end
