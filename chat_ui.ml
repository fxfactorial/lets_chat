open Nodejs_kit

let enter = 13

let () =
  Lwt.async begin fun () ->

    let chat_input =
      Dom_html.getElementById "chat_input"
      |> Dom_html.CoerceTo.input
    in

    let chat_input = Js.Opt.get chat_input (fun _ -> assert false) in

    Lwt_js_events.keydowns chat_input begin fun ev _ ->

      if ev##.keyCode = enter then begin


        let as_text = chat_input##.value in

        Js.to_string as_text |> print_endline;
        Printf.sprintf
          "socketio.emit(\"message_to_server\", {message:\"%s\"})"
          (Js.to_string as_text)
        |> Js.Unsafe.eval_string |> ignore;

        chat_input##.value := !$""

      end;
      Lwt.return ()
    end
  end
