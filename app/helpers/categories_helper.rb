module CategoriesHelper
  def nested_li(objects, &block)
    objects = objects.order(:lft) if objects.is_a? Class

    return '' if objects.size == 0

    output = "<ul style='list-style: none;'><li id=#{objects.first.id}>"
    path = [nil]

    objects.each_with_index do |o, i|
      if o.parent_id != path.last
        # We are on a new level, did we descend or ascend?
        if path.include?(o.parent_id)
          # Remove the wrong trailing path elements
          while path.last != o.parent_id
            path.pop
            output << '</li></ul>'
          end
          output << "</li><li id=#{o.id}>"
        else
          path << o.parent_id
          output << "<ul style='list-style: none;'><li id=#{o.id}>"
        end
      elsif i != 0
        output << "</li><li id=#{o.id}>"
      end
      output << capture(o, path.size - 1, &block)
    end

    output << '</li></ul>' * path.length
    output.html_safe
  end
end

