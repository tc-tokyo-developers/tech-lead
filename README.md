# TECH::LEAD

[![Build Status](https://travis-ci.org/tc-tokyo-developers/tech-lead.svg?branch=master)](https://travis-ci.org/tc-tokyo-developers/tech-lead)

***
## Description

```
Ruby   2.4.2
Rails  5.0.6
mysql2 0.4.10
```

## Setup

```sh
$ git clone git@github.com:tc-tokyo-developers/tech-lead.git

$ bundle install --path vendor/bundle

$ rails db:create

$ rails db:migrate

$ rails db:seed
```

## Development

1. 作業ブランチ作成

```sh
$ git checkout -b ブランチ名 (feature/xxx or fix/xxx)

$ git commit --allow-empty -m "create pull request"

$ git push origin ブランチ名
```

2. [WIP]をつけてPR作成。

3. 実装

4. [WIP]を外してレビュー依頼

***

## DB設計
