import smtplib

fromaddr = 'sending@example.com'
toaddrs  = ['charlieporth1@gmail.com']
msg = '''
    From: {fromaddr}
    To: {toaddr}
    Subject: testin'     
    This is a test 
    .
'''

msg = msg.format(fromaddr =fromaddr, toaddr = toaddrs[0])
# The actual mail send
server = smtplib.SMTP('gmail-smtp-in.l.google.com:587')
server.starttls()
server.ehlo("example.com")
server.mail(fromaddr)
server.rcpt(toaddrs[0])
server.data(msg)
server.quit()  
