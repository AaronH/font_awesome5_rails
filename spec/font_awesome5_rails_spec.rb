require 'spec_helper'

describe FontAwesome5Rails do
  include RSpecHtmlMatchers
  include ActionView::Context

  describe 'files' do
    it 'should have correct dirs' do
      expect(Dir.exists?('./app/assets/images')).to be_truthy
      expect(Dir.exists?('./app/assets/images/fa5/brands')).to be_truthy
      expect(Dir.exists?('./app/assets/images/fa5/regular')).to be_truthy
      expect(Dir.exists?('./app/assets/images/fa5/solid')).to be_truthy
      expect(Dir.exists?('./app/assets/javascripts')).to be_truthy
      expect(Dir.exists?('./app/assets/stylesheets')).to be_truthy
      expect(Dir.exists?('./app/helpers/font_awesome5/rails')).to be_truthy
    end

    it 'should have correct files' do
      expect(File.exists?('./app/helpers/font_awesome5/rails/icon_helper.rb')).to be_truthy
      expect(File.exists?('./app/assets/javascripts/font_awesome5.js')).to be_truthy
      expect(File.exists?('./app/assets/javascripts/fontawesome-all.min.js')).to be_truthy
      expect(File.exists?('./app/assets/stylesheets/fa-svg-with-js.css')).to be_truthy
      expect(File.exists?('./app/assets/stylesheets/font_awesome5.css')).to be_truthy
      expect(File.exists?('./app/assets/stylesheets/fontawesome-all.css.scss')).to be_truthy
      expect(File.exists?('./app/assets/stylesheets/font_awesome5_webfont.css')).to be_truthy
      expect(File.exists?('./lib/font_awesome5_rails/engine.rb')).to be_truthy
      expect(File.exists?('./lib/font_awesome5_rails/version.rb')).to be_truthy
      expect(File.exists?('./lib/font_awesome5_rails/parsers/fa_icon_parser.rb')).to be_truthy
      expect(File.exists?('./lib/font_awesome5_rails/parsers/fa_layered_icon_parser.rb')).to be_truthy
      expect(File.exists?('./lib/font_awesome5_rails/parsers/fa_stacked_icon_parser.rb')).to be_truthy
      expect(File.exists?('./lib/font_awesome5_rails/parsers/parse_methods.rb')).to be_truthy
    end
  end

  describe 'fa_icon tags' do
    it 'should return correct type tags' do
      expect(fa_icon 'camera-retro').to eq '<i class="fas fa-camera-retro"></i>'
      expect(fa_icon 'camera-retro', type: :fas).to eq '<i class="fas fa-camera-retro"></i>'
      expect(fa_icon 'camera-retro', type: :far).to eq '<i class="far fa-camera-retro"></i>'
      expect(fa_icon 'camera-retro', type: :fal).to eq '<i class="fal fa-camera-retro"></i>'
      expect(fa_icon 'camera-retro', type: :fab).to eq '<i class="fab fa-camera-retro"></i>'
      expect(fa_icon 'camera-retro', type: :solid).to eq '<i class="fas fa-camera-retro"></i>'
      expect(fa_icon 'camera-retro', type: :regular).to eq '<i class="far fa-camera-retro"></i>'
      expect(fa_icon 'camera-retro', type: :light).to eq '<i class="fal fa-camera-retro"></i>'
      expect(fa_icon 'camera-retro', type: :brand).to eq '<i class="fab fa-camera-retro"></i>'
    end

    it 'should return correct class tags' do
      expect(fa_icon 'camera-retro').to eq '<i class="fas fa-camera-retro"></i>'
      expect(fa_icon('camera-retro', class: 'test')).to eq '<i class="fas fa-camera-retro test"></i>'
      expect(fa_icon('camera-retro', class: 'fa-camera-retro')).to eq '<i class="fas fa-camera-retro"></i>'
    end

    it 'should return correct size tags' do
      expect(fa_icon 'camera-retro', size: '3x').to eq '<i class="fas fa-camera-retro fa-3x"></i>'
      expect(fa_icon 'camera-retro', class: 'fa-3x', size: '3x').to eq '<i class="fas fa-camera-retro fa-3x"></i>'
      expect(fa_icon 'camera-retro', size: '3x 2x').to eq '<i class="fas fa-camera-retro fa-3x fa-2x"></i>'
    end

    it 'should return correct animation tags' do
      expect(fa_icon 'camera-retro', animation: 'spin').to eq '<i class="fas fa-camera-retro fa-spin"></i>'
      expect(fa_icon 'camera-retro', class: 'fa-spin', animation: 'spin').to eq '<i class="fas fa-camera-retro fa-spin"></i>'
      expect(fa_icon 'camera-retro', animation: 'spin cog').to eq '<i class="fas fa-camera-retro fa-spin fa-cog"></i>'
    end

    it 'should return correct style tags' do
      expect(fa_icon 'camera-retro', style: 'color: Tomato;').to eq '<i class="fas fa-camera-retro" style="color: Tomato;"></i>'
    end

    it 'should return correct data tags' do
      expect(fa_icon 'camera-retro', data: {'fa-transform': 'rotate-90'}).to eq '<i class="fas fa-camera-retro" data-fa-transform="rotate-90"></i>'
      expect(fa_icon 'camera-retro', data: {fa_transform: 'rotate-90'}).to eq '<i class="fas fa-camera-retro" data-fa-transform="rotate-90"></i>'
    end

    it 'should return correct text tags' do
      expect(fa_icon 'camera-retro', text: 'Camera').to have_tag('i', with: { class: 'fas fa-camera-retro'})
      expect(fa_icon 'camera-retro', text: 'Camera').to have_tag('span', text: 'Camera')
      expect(fa_icon 'camera-retro', text: 'Camera', style: 'color: Tomato;').to have_tag('span', text: 'Camera', with: {style: 'color: Tomato;'})
      expect(fa_icon 'camera-retro', text: 'Camera', size: '3x').to have_tag('span', text: 'Camera', with: {class: 'fa5-text fa-3x'})
    end
  end

  describe 'fa_stacked_icon tags' do
    it 'should return correct tags' do
      expect(fa_stacked_icon 'camera', base: 'circle')
          .to eq '<span class="fa-stack"><i class="fas fa-circle fa-stack-2x"></i><i class="fas fa-camera fa-stack-1x"></i></span>'

      expect(fa_stacked_icon 'camera inverse', base: 'circle')
          .to eq '<span class="fa-stack"><i class="fas fa-circle fa-stack-2x"></i><i class="fas fa-camera fa-inverse fa-stack-1x"></i></span>'

      expect(fa_stacked_icon 'camera inverse', base: 'circle inverse')
          .to eq '<span class="fa-stack"><i class="fas fa-circle fa-inverse fa-stack-2x"></i><i class="fas fa-camera fa-inverse fa-stack-1x"></i></span>'

      expect(fa_stacked_icon 'camera', base: 'circle', type: :far, reverse: false)
          .to eq '<span class="fa-stack"><i class="far fa-circle fa-stack-2x"></i><i class="far fa-camera fa-stack-1x"></i></span>'

      expect(fa_stacked_icon 'camera', base: 'circle', reverse: true)
          .to eq '<span class="fa-stack"><i class="fas fa-camera fa-stack-1x"></i><i class="fas fa-circle fa-stack-2x"></i></span>'

      expect(fa_stacked_icon 'camera', base: 'circle', text: 'Text!')
          .to eq '<span class="fa-stack"><i class="fas fa-circle fa-stack-2x"></i><i class="fas fa-camera fa-stack-1x"></i></span>Text!'
    end
  end

  describe 'fa_layered_icon tags' do
    it 'should return correct tags' do
      expect(fa_layered_icon{ fa_icon 'circle'}).to eq '<span class="fa-layers fa-fw"><i class="fas fa-circle"></i></span>'
      expect(fa_layered_icon(aligned: true){ fa_icon 'circle' }).to eq '<span class="fa-layers fa-fw"><i class="fas fa-circle"></i></span>'
      expect(fa_layered_icon(aligned: false){ fa_icon 'circle' }).to eq '<span class="fa-layers"><i class="fas fa-circle"></i></span>'
      expect(fa_layered_icon(class: 'test'){ fa_icon 'circle' }).to eq '<span class="fa-layers fa-fw test"><i class="fas fa-circle"></i></span>'

      expect(fa_layered_icon(size: '3x'){ fa_icon 'circle' })
          .to eq '<div class="fa-3x"><span class="fa-layers fa-fw"><i class="fas fa-circle"></i></span></div>'

      expect(fa_layered_icon(style: 'background: MistyRose'){ fa_icon 'circle' })
          .to eq '<span class="fa-layers fa-fw" style="background: MistyRose"><i class="fas fa-circle"></i></span>'


      expect(
        fa_layered_icon do
          (fa_icon 'circle') + (fa_icon 'times')
        end
      ).to eq '<span class="fa-layers fa-fw"><i class="fas fa-circle"></i><i class="fas fa-times"></i></span>'
    end
  end
  
end