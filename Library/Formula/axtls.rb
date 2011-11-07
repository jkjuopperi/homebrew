require 'formula'

class Axtls < Formula
  url 'http://sourceforge.net/projects/axtls/files/1.4.4/axTLS-1.4.4.tar.gz'
  homepage 'http://axtls.sourceforge.net/'
  md5 '313f40f91e213147677e1df04d8531e9'

  def patches
    # Won't link on MAC
    DATA
  end

  def install
    f = File.open('config/.config', 'w')
    f.write(config())
    f.close
    system "make oldconfig"
    system "make"
    system "make install"
  end

  def config
    return <<-EOT
#
# Automatically generated make config: don't edit
#
HAVE_DOT_CONFIG=y
CONFIG_PLATFORM_LINUX=y
# CONFIG_PLATFORM_CYGWIN is not set
# CONFIG_PLATFORM_WIN32 is not set

#
# General Configuration
#
PREFIX="#{prefix}"
# CONFIG_DEBUG is not set
CONFIG_STRIP_UNWANTED_SECTIONS=y
# CONFIG_VISUAL_STUDIO_7_0 is not set
# CONFIG_VISUAL_STUDIO_8_0 is not set
# CONFIG_VISUAL_STUDIO_10_0 is not set
CONFIG_VISUAL_STUDIO_7_0_BASE=""
CONFIG_VISUAL_STUDIO_8_0_BASE=""
CONFIG_VISUAL_STUDIO_10_0_BASE=""
CONFIG_EXTRA_CFLAGS_OPTIONS="-Wall -pipe"
CONFIG_EXTRA_LDFLAGS_OPTIONS=""

#
# SSL Library
#
# CONFIG_SSL_SERVER_ONLY is not set
# CONFIG_SSL_CERT_VERIFICATION is not set
# CONFIG_SSL_ENABLE_CLIENT is not set
CONFIG_SSL_FULL_MODE=y
# CONFIG_SSL_SKELETON_MODE is not set
# CONFIG_SSL_PROT_LOW is not set
# CONFIG_SSL_PROT_MEDIUM is not set
CONFIG_SSL_PROT_HIGH=y
# CONFIG_SSL_USE_DEFAULT_KEY is not set
CONFIG_SSL_PRIVATE_KEY_LOCATION=""
CONFIG_SSL_PRIVATE_KEY_PASSWORD=""
CONFIG_SSL_X509_CERT_LOCATION=""
# CONFIG_SSL_GENERATE_X509_CERT is not set
CONFIG_SSL_X509_COMMON_NAME=""
CONFIG_SSL_X509_ORGANIZATION_NAME=""
CONFIG_SSL_X509_ORGANIZATION_UNIT_NAME=""
# CONFIG_SSL_ENABLE_V23_HANDSHAKE is not set
CONFIG_SSL_HAS_PEM=y
CONFIG_SSL_USE_PKCS12=y
CONFIG_SSL_EXPIRY_TIME=24
CONFIG_X509_MAX_CA_CERTS=150
CONFIG_SSL_MAX_CERTS=3
# CONFIG_SSL_CTX_MUTEXING is not set
CONFIG_USE_DEV_URANDOM=y
# CONFIG_WIN32_USE_CRYPTO_LIB is not set
# CONFIG_OPENSSL_COMPATIBLE is not set
# CONFIG_PERFORMANCE_TESTING is not set
# CONFIG_SSL_TEST is not set
# CONFIG_AXTLSWRAP is not set
# CONFIG_AXHTTPD is not set
# CONFIG_HTTP_STATIC_BUILD is not set
CONFIG_HTTP_PORT=0
CONFIG_HTTP_HTTPS_PORT=0
CONFIG_HTTP_SESSION_CACHE_SIZE=0
CONFIG_HTTP_WEBROOT=""
CONFIG_HTTP_TIMEOUT=0
# CONFIG_HTTP_HAS_CGI is not set
CONFIG_HTTP_CGI_EXTENSIONS=""
# CONFIG_HTTP_ENABLE_LUA is not set
CONFIG_HTTP_LUA_PREFIX=""
# CONFIG_HTTP_BUILD_LUA is not set
CONFIG_HTTP_CGI_LAUNCHER=""
# CONFIG_HTTP_DIRECTORIES is not set
# CONFIG_HTTP_HAS_AUTHORIZATION is not set
# CONFIG_HTTP_HAS_IPV6 is not set
# CONFIG_HTTP_ENABLE_DIFFERENT_USER is not set
CONFIG_HTTP_USER=""
# CONFIG_HTTP_VERBOSE is not set
# CONFIG_HTTP_IS_DAEMON is not set

#
# Language Bindings
#
# CONFIG_BINDINGS is not set
# CONFIG_CSHARP_BINDINGS is not set
# CONFIG_VBNET_BINDINGS is not set
CONFIG_DOT_NET_FRAMEWORK_BASE=""
# CONFIG_JAVA_BINDINGS is not set
CONFIG_JAVA_HOME=""
# CONFIG_PERL_BINDINGS is not set
CONFIG_PERL_CORE=""
CONFIG_PERL_LIB=""
# CONFIG_LUA_BINDINGS is not set
CONFIG_LUA_CORE=""

#
# Samples
#
# CONFIG_SAMPLES is not set
# CONFIG_C_SAMPLES is not set
# CONFIG_CSHARP_SAMPLES is not set
# CONFIG_VBNET_SAMPLES is not set
# CONFIG_JAVA_SAMPLES is not set
# CONFIG_PERL_SAMPLES is not set
# CONFIG_LUA_SAMPLES is not set

#
# BigInt Options
#
# CONFIG_BIGINT_CLASSICAL is not set
# CONFIG_BIGINT_MONTGOMERY is not set
CONFIG_BIGINT_BARRETT=y
CONFIG_BIGINT_CRT=y
# CONFIG_BIGINT_KARATSUBA is not set
MUL_KARATSUBA_THRESH=0
SQU_KARATSUBA_THRESH=0
CONFIG_BIGINT_SLIDING_WINDOW=y
CONFIG_BIGINT_SQUARE=y
# CONFIG_BIGINT_CHECK_ON is not set
CONFIG_INTEGER_32BIT=y
# CONFIG_INTEGER_16BIT is not set
# CONFIG_INTEGER_8BIT is not set
    EOT
  end
end

__END__
diff --git a/ssl/Makefile b/ssl/Makefile
index aafe7bc..b4232a7 100644
--- a/ssl/Makefile
+++ b/ssl/Makefile
@@ -44,7 +44,7 @@ endif
 
 ifndef CONFIG_PLATFORM_WIN32
 TARGET1=$(AXTLS_HOME)/$(STAGE)/libaxtls.a
-BASETARGET=libaxtls.so
+BASETARGET=libaxtls
 CRYPTO_PATH=$(AXTLS_HOME)/crypto/
 ifdef CONFIG_PLATFORM_CYGWIN
 TARGET2=$(AXTLS_HOME)/$(STAGE)/libaxtls.dll.a
@@ -96,8 +96,8 @@ $(TARGET1) : $(CRYPTO_OBJ) $(OBJ)
 
 $(TARGET2) : $(CRYPTO_OBJ) $(OBJ)
 ifndef CONFIG_PLATFORM_CYGWIN
-	$(LD) $(LDFLAGS) $(LDSHARED) -Wl,-soname,$(LIBMAJOR) -o $(AXTLS_HOME)/$(STAGE)/$(LIBMINOR) $(CRYPTO_OBJ) $(OBJ)
-	cd $(AXTLS_HOME)/$(STAGE); ln -sf $(LIBMINOR) $(LIBMAJOR); ln -sf $(LIBMAJOR) $(BASETARGET); cd -
+	$(LD) $(LDFLAGS) $(LDSHARED) -dynamiclib -Wl,-install_name -Wl,$(LIBMAJOR) -o $(AXTLS_HOME)/$(STAGE)/$(LIBMINOR).dylib $(CRYPTO_OBJ) $(OBJ)
+	cd $(AXTLS_HOME)/$(STAGE); ln -sf $(LIBMINOR).dylib $(LIBMAJOR).dylib; ln -sf $(LIBMAJOR).dylib $(BASETARGET).dylib; cd -
 else
 	$(LD) $(LDFLAGS) $(LDSHARED) -o $(AXTLS_HOME)/$(STAGE)/cygaxtls.dll \
     -Wl,--out-implib=$(AXTLS_HOME)/$(STAGE)/libaxtls.dll.a \

diff --git a/Makefile b/Makefile
index 036a29e..16abb23 100644
--- a/Makefile
+++ b/Makefile
@@ -89,8 +89,7 @@ win32_demo:
 	$(MAKE) win32releaseconf
 
 install: $(PREFIX) all
-	cp --no-dereference $(STAGE)/libax* $(PREFIX)/lib
-	chmod 755 $(PREFIX)/lib/libax* 
+	install -m 755 $(STAGE)/libax* $(PREFIX)/lib
 ifdef CONFIG_SAMPLES
 	install -m 755 $(STAGE)/ax* $(PREFIX)/bin 
 endif

