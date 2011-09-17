module ZonesHelper

  def zones_index
    link_to "Back to Zones Index", zones_path
  end

  def to_table(array)
    table = '<table>'
    array.each do |row|
      table << '<tr>'
      if row.is_a?(Array)
        row.each do |cell|
          table << "<td>#{cell}</td>"
        end
      else
        table << "<td>#{row}</td>"
      end
      table << '</tr>'
    end
    table << '</table>'
    return raw(table)
  end
end
