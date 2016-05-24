module Spree
  ProductsHelper.class_eval do
    def cache_key_for_products
      count = @products.try(:count)
      max_updated_at = (@products.try(:maximum, :updated_at) || Date.today).to_s(:number)
      "#{I18n.locale}/#{current_currency}/spree/products/all-#{params[:page]}-#{max_updated_at}-#{count}-#{Spree::Config[:theme_name]}-#{Spree::Taxon.pluck(:is_featured).to_sentence}"
    end

    def cache_key_for_taxons
      max_updated_at = @taxons.maximum(:updated_at).to_i
      parts = [@taxon.try(:id), max_updated_at].compact.join("-")
      "#{I18n.locale}/taxons/#{parts}/#{Spree::Config[:theme_name]}"
    end

    def color_option_value(variant)
      variant.option_values.joins(:option_type).find_by(spree_option_types: { presentation: 'Color' })
    end

    def non_color_option_types(product)
      product.option_types.where.not(presentation: 'Color')
    end

    def short_product_descritpion(product)
      truncate(product.description, length: 100, omission: '')
    end

    def empty_product_properties_count(product_properties)
      product_properties.where.not(value: '').size
    end
  end
end
