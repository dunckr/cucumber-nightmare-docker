# Cucumber Nightmare Docker [![Build Status](https://travis-ci.org/dunckr/cucumber-nightmare-docker.svg?branch=master)](https://travis-ci.org/dunckr/cucumber-nightmare-docker)

[Cucumber](https://github.com/cucumber/cucumber-js) tests driven by [Nightmare](http://www.nightmarejs.org/) inside a [Docker](https://docker.com) container.

![](https://raw.githubusercontent.com/dunckr/imgs/master/cucumber-nightmare-docker.gif)

## Setup

Install [Docker](https://www.docker.com/) and [XQuartz](https://www.xquartz.org/):

```sh
brew cask install docker xquartz
```

## Usage

Create

```sh
make create
```

Build

```sh
make build
```

Start

```sh
make start
```

sh

```sh
make sh
```

Stop

```sh
make stop
```

Remove

```sh
make rm
```

## Stop xQuartz opening XTern

```sh
defaults write org.macosforge.xquartz.X11 nolisten_tcp 0
defaults write org.macosforge.xquartz.X11 app_to_run /usr/bin/true
```

## License

MIT © [Duncan Beaton](http://dunckr.com)
