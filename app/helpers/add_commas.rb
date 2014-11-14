helpers do

  def add_commas(integer)
    integer.to_s.reverse.scan(/(?:\d*\.)?\d{1,3}-?/).join(',').reverse
  end

end