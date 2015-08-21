require 'spec_helper'

describe RecipesController do
  render_views
  describe "index" do
    before do
      recipe_names = ['Baked Potato w/ Cheese',
                      'Garlic Mashed Potatoes',
                      'Potatoes Au Gratin',
                      'Baked Brussels Sprouts']

      recipe_names.each do |name|
        Recipe.create!(name: name)
      end

      xhr :get, :index, format: :json, keywords: keywords
    end

    subject(:results) do
      JSON.parse(response.body)
    end

    extract_name = lambda do |object|
      object['name']
    end

    context 'when the search finds results' do
      let(:keywords) { 'baked' }

      it 'should return with success code 200' do
        expect(response.status).to eq(200)
      end

      it 'returns two results' do
        expect(results.size).to eq(2)
      end

      it 'includes Baked Potato with Cheese' do
        found_recipes = results.map { |result| extract_name.call(result) }
        expect(found_recipes).to include('Baked Potato w/ Cheese')
      end

      it 'includes Baked Brussels Sprouts' do
        found_recipes = results.map { |result| extract_name.call(result) }
        expect(found_recipes).to include('Baked Brussels Sprouts')
      end
    end

    context 'when the search does not find results' do
      let(:keywords) { 'foo' }

      it 'does not return results' do
        expect(results.size).to eq(0)
      end
    end

  end
end
