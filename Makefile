PAGES = index.html legal.html

page: $(PAGES)
	cp -r assets/* build/

%.html: %.md
	mkdir -p build
	pandoc --standalone --template template.html $< -o build/$@

publish: page
	rsync -r -a --delete --progress build/ klockenschooster:/var/www/janw.name

clean:
	rm -r build

.PHONY: clean publish
