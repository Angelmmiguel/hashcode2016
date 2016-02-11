class Output
  @commands = []

  def self.add_command(str)
    @commands << str
  end

  def self.bulk_file(path)
    @commands.unshift(@commands.size)
    File.open(path, 'w') do |file|
      file.write(@commands.join("\n"))
    end
  end
end
