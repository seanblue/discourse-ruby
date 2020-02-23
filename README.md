## Discourse Ruby Markdown Plugin

### Overview

Adds ruby markdown support to Discourse

Based on https://github.com/lostandfound/markdown-it-ruby.

### Examples

#### Add furigana to a single character
`{何|なに}` &rarr; `<ruby>何<rt>なに</rt></ruby>` &rarr; <ruby>何<rt>なに</rt></ruby>

#### Add furigana to specific characters

`{漢字|かん|じ}` &rarr; `<ruby>漢<rt>かん</rt>字<rt>じ</rt></ruby>` &rarr; <ruby>漢<rt>かん</rt>字<rt>じ</rt></ruby>

#### Add furigana across multiple characters
`{今日|きょう}` &rarr; `<ruby>今日<rt>きょう</rt></ruby>` &rarr; <ruby>今日<rt>きょう</rt></ruby>

#### Add furigana to words with okurigana
`{始|はじ}まる` &rarr; `<ruby>始<rt>はじ</rt></ruby>まる` &rarr; <ruby>始<rt>はじ</rt></ruby>まる

#### Add furigana to words with kana in the middle of the word
`{振|ふ}り{仮名|が|な}` &rarr; `<ruby>振<rt>ふ</rt></ruby>り<ruby>仮<rt>が</rt>名<rt>な</rt></ruby>` &rarr; <ruby>振<rt>ふ</rt></ruby>り<ruby>仮<rt>が</rt>名<rt>な</rt></ruby>
<br/>
OR
<br/>
`{振り仮名|ふ||が|な}` &rarr; `<ruby>振<rt>ふ</rt>り<rt></rt>仮<rt>が</rt>名<rt>な</rt></ruby>` &rarr; <ruby>振<rt>ふ</rt>り<rt></rt>仮<rt>が</rt>名<rt>な</rt></ruby>
