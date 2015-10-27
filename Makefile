pkgs_main := electron.main_process
pkgs_renderer := electron.renderer

js_debug := --debug-info --no-inline --pretty

run:all clean
	electron .

all:
	@ocamlfind ocamlc -g chat.ml -package $(pkgs_main) -linkpkg
	@js_of_ocaml $(js_debug) a.out -o chat.js

	@ocamlfind ocamlc -g chat_ui.ml -package $(pkgs_renderer) -linkpkg
	@js_of_ocaml $(js_debug) a.out -o chat_ui.js

	# @echo "Now Compiling Sass files..."
	# node-sass client/sass/main.scss client/css/main.css \
	# --output-style=compressed --output --source-map=true
	@echo "Compiled"

# watch:
# 	node-sass client/sass/main.scss client/css/main.css \
# 	--watch --output-style=expanded


clean:
	@rm -f chat.cmi chat.cmo chat.cmt a.out \
	chat_ui.cmi chat_ui.cmo chat_ui.cmt a.out

.PHONY:clean all watch clientclient
