;; README.zh.txt                               -*- coding: utf-8; -*-
;; This is the README installed with Gpg4win. Lines with a ; in the first
;; column are considered a comment and not included in the actually
;; installed version.  Certain keywords are replaced by the Makefile;
;; those words are enclosed by exclamation marks.

                   Gpg4win 的中文 README 自述文件
                   ===============================

此乃 Gpg4win，版本 !VERSION! (!BUILD_ISODATE!)。

内容：

     1. 重要注意事项
     2. 变化情况
     3. 其他注意事项
     4. 历史版本
     5. 所含软件的版本
     6. 法律声明


1. 重要注意事项
=================

在发布时，英文版的电子书“Gpg4win 概要”尚未为 Gpg4win 3 更新，但其仍
然不失为一份有用的文档，可以在一般情况下指导如何使用本软件。你可以在系
统中找到它（取决于 Windows 版本）或在网上阅读：

    https://www.gpg4win.org/doc/en/gpg4win-compendium.html

请注意，德语 4.0.0 版本是最新的且仅以pdf格式提供。

请在开始使用 Gpg4win 前先阅读本说明的第3节“其他注意事项”。

概要中有更多关于手动或自动安装的提示。


系统要求
-------------------

Gpg4win 可以运行在在 Windows 7 或更高版本（最高 Windows 10）上。同时支
持 32 位和 64 位系统。如果你仍使用 Windows XP，那么 Gpg4win 的某些部件
可能可以使用，但无官方支持。

针对 Outlook 的插件 GpgOL 与 Microsoft Outlook 2010、2013、2016兼容
（32位和64位），并支持通过 SMTP/IMAP 和 MS Exchange Server（2010版或更
新）传输电子邮件。

由于安全原因，Gpg4win 3.1.2版的 Outlook 2003和2007的支持被移除。

（系统要求变更请见 https://www.gpg4win.org/system-requirements.html）

2. 变化
=========

!VERSION! 版本中包含的 Gpg4win 组件有：

!COMPONENTS!

Gpg4win !VERSION! (!BUILD_ISODATE!) 版本的新变化
-----------------------------------------

3. 其他注意事项
=================

- GpgOL

  * 不能正确处理作为附件转发的加密邮件。

  * 不支持集成的 Microsoft 仅 OLE（链接和嵌入）对象。

  * 本地化仅可用于荷兰语、德语和葡萄牙语。

- 通用

  * 对于未来的版本，我们计划进一步自动化 GpgOL。
    这将设置 GnuPG 选项为：

        trust-model tofu+pgp

    由于并非所有地方都能正确处理这个选项（尤其是 Kleopatra 的文件验证
    对话框），所以这不是默认的。
    您也可以手动将其添加到gpg.conf。GpgOL已支持此 trust-model信任模型。


4. 历史版本
=============

下面列出的是源发行版新闻文件中记录的更改。最新的更改列表也可从以下网址
获得：
    https://www.gpg4win.org/change-history.html

!NEWSFILE!


5. 所含软件的版本
===================

!VERSIONINFO!


6. 与独立软件包有关的法律声明
===============================

Gpg4win 由几个独立开发的软件包组成，拥有不同的许可条件。然而，这些软件
包中的大多数都可以在 GNU通用公共许可证（GPL）下使用，或者与 GNU通用公
共许可证兼容。
这些软件包的共同点是，它们都是自由软件，这意味着它们可以不受限制地使用，
可以被研究、修改，修改后可以分发。如果源文件（如 gpg4win-src-x.y.z.exe）
与二进制文件一起分发，并且声明使用 GPL 许可证，那么大多情况下分发是毫
无问题的。

下面是版权声明列表。

!PKG-COPYRIGHT!


*** 文件结尾 ***

***end of file ***
