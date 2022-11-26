# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Changed
- `ssh`: no longer accept RSA keys < 2048 bits for client & server (host) authentication
- `docker-compose` & sample `ansible` playbook:
   - read-only container root filesystem
   - drop capabilities
   - enable `no-new-privileges` option
   - added memory & cpu limits

## [0.2.1] - 2020-11-25
### Fixed
- merged some `RUN` layers

## [0.2.0] - 2019-07-07
### Added
- added openssh client
- create ssh keypair on container startup
  (to be able to git pull/push in storage hook)

## [0.1.0] - 2019-07-07

[Unreleased]: https://github.com/fphammerle/docker-radicale/compare/0.2.1...HEAD
[0.2.1]: https://github.com/fphammerle/docker-radicale/compare/0.2.0...0.2.1
[0.2.0]: https://github.com/fphammerle/docker-radicale/compare/0.1.0...0.2.0
[0.1.0]: https://github.com/fphammerle/docker-radicale/tree/0.1.0
