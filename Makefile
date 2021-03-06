SOURCES := $(wildcard *.md)
PAGES := $(patsubst %.md,%.html,$(SOURCES))

page: $(PAGES)
	cp -r assets/* build/

%.html: %.md
	mkdir -p build
	pandoc --standalone --template template.html $< -o build/$@

publish: page
	rsync -r -a --delete --progress build/ janw:/var/www/janw.name

publish-pi: page
	rsync -r -a --delete --progress build/ pi:/var/www/janw.name

clean:
	rm -r build

.PHONY: clean publish
