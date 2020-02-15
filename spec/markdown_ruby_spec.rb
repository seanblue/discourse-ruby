# frozen_string_literal: true

require 'rails_helper'

describe PrettyText do
  before do
    SiteSetting.queue_jobs = false
  end

  it "can still parse non-markdown" do
    markdown = <<~MD
      ordinary text
    MD

    html = <<~HTML
      <p>ordinary text</p>
    HTML

    cooked = PrettyText.cook markdown.strip
    expect(cooked).to eq(html.strip)
  end

  it "can generate English ruby text for English base text" do
    markdown = <<~MD
      {hello|goodbye}
    MD

    html = <<~HTML
      <p><ruby>hello<rt>goodbye</rt></ruby></p>
    HTML

    cooked = PrettyText.cook markdown.strip
    expect(cooked).to eq(html.strip)
  end

  it "doesn't generate multiple rt tags for English text" do
    markdown = <<~MD
      {hello|good|bye}
    MD

    html = <<~HTML
      <p><ruby>hello<rt>good|bye</rt></ruby></p>
    HTML

    cooked = PrettyText.cook markdown.strip
    expect(cooked).to eq(html.strip)
  end

  it "can generate Japanese ruby text for English base text" do
    markdown = <<~MD
      {hello|こんにちは}
    MD

    html = <<~HTML
      <p><ruby>hello<rt>こんにちは</rt></ruby></p>
    HTML

    cooked = PrettyText.cook markdown.strip
    expect(cooked).to eq(html.strip)
  end

  it "can generate English ruby text for Japanese base text" do
    markdown = <<~MD
      {こんにちは|hello}
    MD

    html = <<~HTML
      <p><ruby>こんにちは<rt>hello</rt></ruby></p>
    HTML

    cooked = PrettyText.cook markdown.strip
    expect(cooked).to eq(html.strip)
  end

  it "can generate one set of furigana per markdown" do
    markdown = <<~MD
      {漢|かん}{字|じ}
    MD

    html = <<~HTML
      <p><ruby>漢<rt>かん</rt></ruby><ruby>字<rt>じ</rt></ruby></p>
    HTML

    cooked = PrettyText.cook markdown.strip
    expect(cooked).to eq(html.strip)
  end

  it "can generate multiple sets of furigana per markdown" do
    markdown = <<~MD
      {漢字|かん|じ}
    MD

    html = <<~HTML
      <p><ruby>漢<rt>かん</rt>字<rt>じ</rt></ruby></p>
    HTML

    cooked = PrettyText.cook markdown.strip
    expect(cooked).to eq(html.strip)
  end

  it "can generate furigana across multiple kanji" do
    markdown = <<~MD
      {漢字|かんじ}
    MD

    html = <<~HTML
      <p><ruby>漢字<rt>かんじ</rt></ruby></p>
    HTML

    cooked = PrettyText.cook markdown.strip
    expect(cooked).to eq(html.strip)
  end

  it "can generate furigana that includes | when more furigana groups specified than kanji" do
    markdown = <<~MD
      {漢|かん|じ}
    MD

    html = <<~HTML
      <p><ruby>漢<rt>かん|じ</rt></ruby></p>
    HTML

    cooked = PrettyText.cook markdown.strip
    expect(cooked).to eq(html.strip)
  end

  it "can generate empty rt tags" do
    markdown = <<~MD
      {振り仮名|ふ||が|な}
    MD

    html = <<~HTML
      <p><ruby>振<rt>ふ</rt>り<rt></rt>仮<rt>が</rt>名<rt>な</rt></ruby></p>
    HTML

    cooked = PrettyText.cook markdown.strip
    expect(cooked).to eq(html.strip)
  end

  it "can generate sentences" do
    markdown = <<~MD
      {勉強|べん|きょう}は{大変|たい|へん}です。
    MD

    html = <<~HTML
      <p><ruby>勉<rt>べん</rt>強<rt>きょう</rt></ruby>は<ruby>大<rt>たい</rt>変<rt>へん</rt></ruby>です。</p>
    HTML

    cooked = PrettyText.cook markdown.strip
    expect(cooked).to eq(html.strip)
  end

  it "can escape { character" do
    markdown = <<~MD
      \\{漢字|かん|じ}
    MD

    html = <<~HTML
      <p>{漢字|かん|じ}</p>
    HTML

    cooked = PrettyText.cook markdown.strip
    expect(cooked).to eq(html.strip)
  end

  it "can escape } character" do
    markdown = <<~MD
      {漢字|かん|じ\\}
    MD

    html = <<~HTML
      <p>{漢字|かん|じ}</p>
    HTML

    cooked = PrettyText.cook markdown.strip
    expect(cooked).to eq(html.strip)
  end

  it "can escape | character to include in base text" do
    markdown = <<~MD
      {漢字\\|かん|じ}
    MD

    html = <<~HTML
      <p><ruby>漢字|かん<rt>じ</rt></ruby></p>
    HTML

    cooked = PrettyText.cook markdown.strip
    expect(cooked).to eq(html.strip)
  end

  it "can escape all | characters" do
    markdown = <<~MD
      {漢字\\|かん\\|じ}
    MD

    html = <<~HTML
      <p>{漢字|かん|じ}</p>
    HTML

    cooked = PrettyText.cook markdown.strip
    expect(cooked).to eq(html.strip)
  end

  it "can apply additional markdown around entire ruby markdown" do
    markdown = <<~MD
      **{base text|ruby text}**
    MD

    html = <<~HTML
      <p><strong><ruby>base text<rt>ruby text</rt></ruby></strong></p>
    HTML

    cooked = PrettyText.cook markdown.strip
    expect(cooked).to eq(html.strip)
  end

  it "can apply additional markdown around ruby text" do
    markdown = <<~MD
      {漢字|**かん**|*じ*}
    MD

    html = <<~HTML
      <p><ruby>漢<rt><strong>かん</strong></rt>字<rt><em>じ</em></rt></ruby></p>
    HTML

    cooked = PrettyText.cook markdown.strip
    expect(cooked).to eq(html.strip)
  end

end
