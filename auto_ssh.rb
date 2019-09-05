# !/usr/bin/ruby -w
# -*- coding : utf-8 -*-

TARGET_SERVERS = [
    'username@ssh1.test.com',
    'username@ssh2.test.com'
];

def displayTargetServers()
    puts
    puts("Servers List: ");
    puts

    idx = 0;

    while idx < TARGET_SERVERS.length do
        printf("%-4s %s\n",idx + 1, TARGET_SERVERS[idx]);
        idx += 1;
    end
    return nil;
end

def chooseServer()
    
    print("\nPlease choose a server No: ");
    
    serverNo = Integer(gets)

    if serverNo < 1 or serverNo > TARGET_SERVERS.length 
        puts("Input paramter invalidate!");
        exit;
    end

    targetServer = TARGET_SERVERS[serverNo-1];
    password = '***';
 
=begin
    if 'special_server'.eql?(targetServer)
        password = '***';
    else
        password = '***';
    end
=end

    return targetServer, password;
end

def executeCmd((server, password))
    cmd = <<EOF
        expect -c "
            set timeout 3
            spawn ssh #{server}
            expect {
                "yes/no" {send yes\\r;exp_continue;}
                "password" {send #{password}\\r;exp_continue;}
                "$*" {send 'cd /opt/active/logs\\r'}
            }
            interact
        "
EOF

system(cmd);

end

displayTargetServers();

servers = chooseServer();

executeCmd(servers);
