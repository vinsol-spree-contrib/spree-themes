module Spree
  Product.class_eval do
    def uniq_options(option_type)
      sorted_option_values(option_type) do |value, _uniq_options, _variant|
        _uniq_options[_variant.id] = { variant: _variant, option_value_presentation: value.presentation } if value
      end
    end

    def uniq_color_options
      sorted_option_values('Color') do |value, _uniq_options, _variant|
        _uniq_options[value.id] = { variant: _variant, option_value_presentation: value.presentation } if value
      end
    end

    private
      def sorted_option_values(option_type)
        _uniq_options = {}
        variants.reload.map do |_variant|
          value = _variant.option_values.joins(:option_type).where(spree_option_types: { presentation: option_type }).sort do |a, b|
            a.option_type.position <=> b.option_type.position
          end[0]
          yield(value, _uniq_options, _variant)
        end
        _uniq_options
      end
  end
end
