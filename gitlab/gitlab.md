# 已安装好的gitlab对接board

**获取gitlab access token**
获取token的方法：

    登录到gitlab with addmin name， 点击左上角addmin用户 -> setting -> Access 
	Tokens -> input "Name", select "api、read_use、read_repository、
	write_repository、sudo -> Create personal access token -> copy the token 
	and save it

![gitlab](D:\gitlab\20201124100601.png)

**添加gitlab run 到gitlab**

添加gitlab runner 名字为docker， 其中http://10.10.10.10需要修改成gitlab的URL，gitlab_runner_token替换成上一步中获取的token内容， docker-image可以提前获取。

    gitlab-runner register --name docker-executor \
		--url="http://10.10.10.10" \
		--registration-token="gitlab_runner_token" \
		--executor="docker" \
		--docker-image=kaniko-project/executor:dev 
		--non-interactive \
		--tag-list "docker-ci" 
		
添加gitlab runner 名字为shell， 其中http://10.10.10.10需要修改成gitlab的URL，gitlab_runner_token替换成上一步中获取的token内容。

    gitlab-runner register --name shell-executor \
		--url="http://10.10.10.10" \
		--registration-token="gitlab_runner_token" \
		--executor="shell" \
		--non-interactive \
		--tag-list "shell-ci"