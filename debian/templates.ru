Template: dpkg-www/update-apache-config
Type: boolean
Default: true
Description: Do you want to change the apache(-ssl) configuration?
 Allowing access to /cgi-bin/dpkg from any foreign host could allow
 a malicious external user to know your installed packages and try
 possible security exploits. You should therefore disable access
 to dpkg-www from foreign hosts. With apache(-ssl) you should add
 the following lines to /etc/apache(-ssl)/access.conf:
 .
    # Disable execution of dpkg from remote hosts
    <Location /cgi-bin/dpkg>
    order deny,allow
    deny from all
    allow from localhost
    allow from .your.domain
    </Location>
 .
 If you answer YES to this question and the apache configuration files
 are found the dpkg-www installation script will make these changes
 automatically for you. If apache is not installed, you are using a
 different httpd server or you answer NO to this question you should
 make the appropriate changes yourself.
Description-ru: ������ �������� ��������� apache(-ssl)?
 ������  �  ��������  /cgi-bin/dpkg  � ������  ������������ ����� �����
 �������� � ����, ��� ����������� ������������ ����� ������ ����� � ���
 �����������  ������  �  ���������� �������� �������. � ��������� �����
 �������������  ���������  ������  � dpkg-www � ����������� ������. ���
 apache(-ssl)  ���  ����  ��������  ��������� ������ � ����������� ����
 /etc/apache(-ssl)/access.conf:
 .
     # ��������� ���������� dpkg � ��������� ������
     <Location /cgi-bin/dpkg>
         order deny,allow
         deny from all
         allow from localhost
         allow from .your.domain
     </Location>
 .
 ���� �� ��������� �� �� ���� ������ � ������� ����������� ����� apache
 ��  ��������  ���������  dpkg-www  ������� � ��� ����������� ���������
 �������������. ���� apache �� ����������, �� ����������� ������ ������
 WWW ��� ���� �� ������� ��� �� ���� ������, �� ��� �������� �������
 ��������������� ��������� ��������������.
