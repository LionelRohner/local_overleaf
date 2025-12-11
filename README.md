# Overleaf Toolkit

This repository contains the Overleaf Toolkit, the standard tools for running a local
instance of [Overleaf](https://overleaf.com). This toolkit will help you to set up and administer both Overleaf Community Edition (free to use, and community supported), and Overleaf Server Pro (commercial, with professional support).

The [Developer wiki](https://github.com/overleaf/overleaf/wiki) contains further documentation on releases, features and other configuration elements.

## Getting Started

Clone this repository locally:

``` sh
git clone https://github.com/overleaf/toolkit.git ./overleaf-toolkit
```

Then follow the [Quick Start Guide](./doc/quick-start-guide.md).

## Documentation

See [Documentation Index](./doc/README.md)

## Install Latex Packages

TBD

### Troubleshooting

**Issue**:
> Unable to download the checksum of the remote TeX Live database,
but found a local copy, so using that.
>
> You may want to try specifying an explicit or different CTAN mirror,
or maybe you need to specify proxy information if you're behind a firewall;
see the information and examples for the -repository option at
tug.org/texlive/doc/install-tl.html
(and in the output of install-tl --help).

1. **Check the CTAN Mirror**:
   - Verify if the specified CTAN mirror can be accessed. If it cannot be reached, try another mirror from [here](https://ctan.org/mirrors/).

2. **Check Docker DNS Resolution**:
   - If the issue persists, check if Docker can resolve hostnames. Enter the Docker container and run `curl` or `ping` with a known working URL:

     ```bash
     curl http://www.google.com
     ```

3. **Modify Docker DNS Settings**:
   - If DNS resolution fails, add a common DNS server to `/etc/docker/daemon.json`. For example, use Cloudflare's DNS servers:

     ```json
     {
         "dns": [
             "1.1.1.1",
             "1.0.0.1",
             "8.8.8.8",
             "9.9.9.9"
         ]
     }
     ```

   - After saving changes to `daemon.json`, restart the Docker service for the changes to take effect.

## Getting Help

Users of the free Community Edition should [open an issue on github](https://github.com/overleaf/toolkit/issues).

Users of Server Pro should contact `support@overleaf.com` for assistance.

In both cases, it is a good idea to include the output of the `bin/doctor` script in your message.
