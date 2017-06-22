
.DEFAULT_GOAL: CREATE_INIT

CREATE_INIT:
	./initrd.sh $(TOPDIR) >/dev/null 2>&1

clean:
	rm -rf $(TOPDIR)/initrd/sbin \
		$(TOPDIR)/initrd/bin/ \
		$(TOPDIR)/initrd/dev/ \
		$(TOPDIR)/initrd/etc/ \
		$(TOPDIR)/initrd/lib/ \
		$(TOPDIR)/initrd/proc/ \
		$(TOPDIR)/initrd/sys/ \
		$(TOPDIR)/initrd/initrd.img \
		$(TOPDIR)/initrd.img
