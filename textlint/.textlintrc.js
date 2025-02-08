'use strict';
module.exports = {
  plugins: { 
    'latex2e': {
      extensions: ['.ltx']
    }
  },
  filters: {
    comments: true,
    'node-types': {
      nodeTypes: [
        {
          ruleId: 'first-sentence-length',
          types: ['Link']
        }
      ]
    }
  },
  rules: {
    'preset-ja-spacing': {
      'ja-space-between-half-and-full-width': {
        space: ['alphabets', 'numbers']
      },
      'ja-space-around-code': {
        before: true,
        after: true
      },
      'ja-space-around-link': {
        before: true,
        after: true
      }
    },
    'preset-ja-technical-writing': {
      'ja-no-weak-phrase': false,
      'ja-no-mixed-period': {
        periodMark: '。',
        allowPeriodMarks: ['。', '．', ':', '：', '、', '，'],
        allowEmoji: true,
      },
      'no-exclamation-question-mark': false,
      'no-mix-dearu-desumasu': {
        preferInHeader: '',
        preferInBody: '',
        preferInList: '',
      },
    },
    prh: {
      rulePaths: [
        "~/.config/prh/global.yml"
      ]
    },
    terminology: {
      defaultTerms: true,
      skip: ["Link"]
    },
    'ja-overlooked-typo': true,
    'first-sentence-length': {
      max: 50
    },
    '@textlint-ja/no-synonyms': true,
    'ja-no-inappropriate-words': true,
    'abbr-within-parentheses': true,
  }
}
