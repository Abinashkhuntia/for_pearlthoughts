import pyOpenSSL

def check_ssl_expiry(domain):
  cert = pyOpenSSL.crypto.load_certificate(pyOpenSSL.crypto.FILETYPE_PEM,
                                         open(f"{domain}.pem", "rb").read())
  expiry_date = cert.get_notAfter()
  days_to_expiry = (expiry_date - datetime.datetime.now()).days

  if days_to_expiry <= 30:
    print(f"SSL certificate for {domain} will expire in {days_to_expiry} days.")