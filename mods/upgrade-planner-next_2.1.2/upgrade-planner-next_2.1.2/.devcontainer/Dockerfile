FROM roangzero1/factorio-mod:luarocks5.3-ubuntu as base

RUN apt-get update \
  && apt-get install --no-install-recommends -y \
      ca-certificates \
      ninja-build \
      clang\
      cmake\
      make\
  && git clone https://github.com/sumneko/lua-language-server.git /opt/lua-language-server \
  && git clone https://github.com/Koihik/LuaFormatter.git /opt/LuaFormatter \
  && ( \
    cd /opt/lua-language-server; \
    git submodule update --init --recursive \
  ) \
  && ( \
    cd /opt/lua-language-server/3rd/luamake; \
    ninja -f ninja/linux.ninja \
  ) \
  && (\
    cd /opt/lua-language-server/; \
    ./3rd/luamake/luamake rebuild \
  ) \
  && (\
    cd /opt/LuaFormatter/; \
    cmake .; \
    make; \
    make install; \
  ) \
  && apt-get remove -y --purge \
      ninja-build \
      clang\
  && apt-get autoremove -y --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

