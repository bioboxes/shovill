FROM bioboxes/biobox-minimal-base@sha256:908bc44aaa5de9a9b519cc3548b7d1e37c8f4f71a815f43ea71091e2980e9974

ADD image/bin    /usr/local/bin
ADD image/share  /usr/local/share

RUN install.sh && rm /usr/local/bin/install.sh
