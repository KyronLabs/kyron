import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "about": MessageLookupByLibrary.simpleMessage("Acerca de"),
      "addAnAnswer":
          MessageLookupByLibrary.simpleMessage("Añadir una respuesta"),
      "agreeAndContinue": MessageLookupByLibrary.simpleMessage(
        "Aceptar y continuar",
      ),
      "answerNumber": (Object a0) => "Respuesta ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("Lente de RA"),
      "attachSystemLog": MessageLookupByLibrary.simpleMessage(
        "Adjuntar el registro del sistema",
      ),
      "aWordPhraseOrTag": MessageLookupByLibrary.simpleMessage(
        "Una palabra, frase o #etiqueta",
      ),
      "block": MessageLookupByLibrary.simpleMessage("Bloquear"),
      "blockAuthor": (Object a0) => "¿Bloquear a ${a0}?",
      "buildDetailsCopied": MessageLookupByLibrary.simpleMessage(
        "Detalles de la compilación copiados",
      ),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
      "change": MessageLookupByLibrary.simpleMessage("Cambiar"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("Cambiar correo"),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
        "Comprobar si Kyron está accesible",
      ),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
        "Revisa tu correo para confirmar tu cuenta.",
      ),
      "closeCommunity": (Object a0) => "¿Cerrar ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Cerrar"),
      "closeThisCommunity": MessageLookupByLibrary.simpleMessage(
        "Cerrar esta comunidad",
      ),
      "confirmPassword": MessageLookupByLibrary.simpleMessage(
        "Confirmar contraseña",
      ),
      "contactSupport": MessageLookupByLibrary.simpleMessage(
        "Contactar con soporte",
      ),
      "continueWithEmail": MessageLookupByLibrary.simpleMessage(
        "Continuar con correo",
      ),
      "copy": MessageLookupByLibrary.simpleMessage("Copiar"),
      "copyReportInstead": MessageLookupByLibrary.simpleMessage(
        "Copiar informe en su lugar",
      ),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "No se pudo abrir el inicio de sesión con Google. ${a0}",
      "couldNotSignOut": (Object a0) => "No se pudo cerrar la sesión: ${a0}",
      "couldNotTakePicture": MessageLookupByLibrary.simpleMessage(
        "No se pudo tomar esa foto.",
      ),
      "create": MessageLookupByLibrary.simpleMessage("Crear"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Crear cuenta"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("Crea tu cuenta"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("Crea tu perfil"),
      "delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
      "deleteThisComment": MessageLookupByLibrary.simpleMessage(
        "¿Eliminar este comentario?",
      ),
      "deleteThisPost": MessageLookupByLibrary.simpleMessage(
        "¿Eliminar esta publicación?",
      ),
      "describeAttachment": MessageLookupByLibrary.simpleMessage(
        "Describir este adjunto",
      ),
      "description": MessageLookupByLibrary.simpleMessage("Descripción"),
      "didCopied": MessageLookupByLibrary.simpleMessage(
        "DID copiado al portapapeles",
      ),
      "done": MessageLookupByLibrary.simpleMessage("Listo"),
      "drafts": MessageLookupByLibrary.simpleMessage("Borradores"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Editar perfil"),
      "emailNotifications": MessageLookupByLibrary.simpleMessage(
        "Notificaciones por correo",
      ),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
        "El seguimiento facial no está disponible en este dispositivo.",
      ),
      "followers": MessageLookupByLibrary.simpleMessage("Seguidores"),
      "following": MessageLookupByLibrary.simpleMessage("Siguiendo"),
      "forgotPassword": MessageLookupByLibrary.simpleMessage(
        "¿Olvidaste tu contraseña?",
      ),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
        "Guías y respuestas a preguntas comunes",
      ),
      "handle": MessageLookupByLibrary.simpleMessage("nombre de usuario"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Centro de ayuda"),
      "helpAndSupport": MessageLookupByLibrary.simpleMessage("Ayuda y soporte"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("En una línea"),
      "itDisappearsForBoth": MessageLookupByLibrary.simpleMessage(
        "Desaparece para ambos.",
      ),
      "itWillBeRemoved": MessageLookupByLibrary.simpleMessage(
        "Se eliminará del hilo.",
      ),
      "keepEditing": MessageLookupByLibrary.simpleMessage("Seguir editando"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Diseño Lagos"),
      "leave": MessageLookupByLibrary.simpleMessage("Salir"),
      "leaveCommunity": (Object a0) => "¿Salir de ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Permitir volver"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Cargar más"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Registro borrado"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Registro copiado"),
      "logIn": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
      "logOut": MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("¿Cerrar sesión?"),
      "message": MessageLookupByLibrary.simpleMessage("Mensaje"),
      "mute": MessageLookupByLibrary.simpleMessage("Silenciar"),
      "mutedAndBlocked": MessageLookupByLibrary.simpleMessage(
        "Silenciados y bloqueados",
      ),
      "mutedWordsAndTags": MessageLookupByLibrary.simpleMessage(
        "Palabras y etiquetas silenciadas",
      ),
      "name": MessageLookupByLibrary.simpleMessage("Nombre"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("Pantalla <nombre>"),
      "newEmailAddress": MessageLookupByLibrary.simpleMessage(
        "Nueva dirección de correo",
      ),
      "newPassword": MessageLookupByLibrary.simpleMessage("Nueva contraseña"),
      "newPost": MessageLookupByLibrary.simpleMessage("Nueva publicación"),
      "nothingToCopy": MessageLookupByLibrary.simpleMessage("Nada que copiar"),
      "notifications": MessageLookupByLibrary.simpleMessage("Notificaciones"),
      "notNow": MessageLookupByLibrary.simpleMessage("Ahora no"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
        "No se envió. Toca para reintentar",
      ),
      "openInBrowser": MessageLookupByLibrary.simpleMessage(
        "Abrir en el navegador",
      ),
      "pageNotFound":
          MessageLookupByLibrary.simpleMessage("Página no encontrada"),
      "pickYourInterests": MessageLookupByLibrary.simpleMessage(
        "Elige tus intereses",
      ),
      "post": MessageLookupByLibrary.simpleMessage("Publicar"),
      "postAnalytics": MessageLookupByLibrary.simpleMessage(
        "Estadísticas de la publicación",
      ),
      "postInCommunity": (Object a0) => "Publicar en ${a0}",
      "postTextCopied": MessageLookupByLibrary.simpleMessage(
        "Texto de la publicación copiado",
      ),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Perfil actualizado"),
      "pushNotifications": MessageLookupByLibrary.simpleMessage(
        "Notificaciones push",
      ),
      "quote": MessageLookupByLibrary.simpleMessage("Citar"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Citar publicación"),
      "reachAPerson": MessageLookupByLibrary.simpleMessage(
        "Contactar a una persona",
      ),
      "remove": MessageLookupByLibrary.simpleMessage("Eliminar"),
      "removeMember": (Object a0) => "¿Eliminar a ${a0}?",
      "removeConversation": MessageLookupByLibrary.simpleMessage(
        "¿Eliminar esta conversación?",
      ),
      "removeMessage": MessageLookupByLibrary.simpleMessage(
        "¿Eliminar este mensaje?",
      ),
      "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage(
        "Respuestas, seguimientos y menciones",
      ),
      "reply": MessageLookupByLibrary.simpleMessage("Responder"),
      "report": MessageLookupByLibrary.simpleMessage("Reportar"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
        "Informe copiado. Pégalo en un correo al soporte.",
      ),
      "reportSent": MessageLookupByLibrary.simpleMessage("Informe enviado"),
      "repost": MessageLookupByLibrary.simpleMessage("Republicar"),
      "reset": MessageLookupByLibrary.simpleMessage("Restablecer"),
      "resetPassword": MessageLookupByLibrary.simpleMessage(
        "Restablecer tu contraseña",
      ),
      "retry": MessageLookupByLibrary.simpleMessage("Reintentar"),
      "save": MessageLookupByLibrary.simpleMessage("Guardar"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("Guardar borrador"),
      "saySomething": (Object a0) => "Di algo a ${a0}",
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
        "Buscar por nombre o usuario",
      ),
      "searchCommunities": MessageLookupByLibrary.simpleMessage(
        "Buscar comunidades",
      ),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Buscar GIFs"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("Buscar idiomas"),
      "searchTrendingTags": MessageLookupByLibrary.simpleMessage(
        "Buscar etiquetas tendencias",
      ),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
        "Alertas de seguridad y cambios en la cuenta",
      ),
      "sendConfirmation": MessageLookupByLibrary.simpleMessage(
        "Enviar confirmación",
      ),
      "sendErrorReport": MessageLookupByLibrary.simpleMessage(
        "Enviar informe de error",
      ),
      "sendFeedback":
          MessageLookupByLibrary.simpleMessage("Enviar comentarios"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Enviar informe"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("Enviar al soporte"),
      "serviceStatus":
          MessageLookupByLibrary.simpleMessage("Estado del servicio"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
        "Compartir el registro de la app con soporte",
      ),
      "signedInAs":
          MessageLookupByLibrary.simpleMessage("Iniciaste sesión como"),
      "signInToKyron": MessageLookupByLibrary.simpleMessage(
        "Iniciar sesión en Kyron",
      ),
      "signupFailed": (Object a0) => "Error al registrarse: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Permanecer"),
      "systemLog": MessageLookupByLibrary.simpleMessage("Registro del sistema"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
        "Cuéntanos qué falta o no funciona",
      ),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
        "El compositor no tiene botón de publicar",
      ),
      "translate": MessageLookupByLibrary.simpleMessage("Traduccir"),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Intentar de nuevo"),
      "undoRepost":
          MessageLookupByLibrary.simpleMessage("Deshacer republicación"),
      "updatePassword": MessageLookupByLibrary.simpleMessage(
        "Actualizar contraseña",
      ),
      "useDifferentAddress": MessageLookupByLibrary.simpleMessage(
        "Usar otra dirección",
      ),
      "whatHappened": MessageLookupByLibrary.simpleMessage("¿Qué pasó?"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "¿Qué pasó y qué debemos revisar?",
      ),
      "whatInPicture": MessageLookupByLibrary.simpleMessage(
        "¿Qué hay en esta imagen?",
      ),
      "whatIsItFor": MessageLookupByLibrary.simpleMessage(
        "¿Para qué es? (opcional)",
      ),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
        "Lo que hiciste, lo que esperabas, lo que pasó",
      ),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
        "Lo que estabas haciendo cuando pasó.",
      ),
      "normalised": (Object a0) => "#\\${a0}",
      "postItSayItShowIt": MessageLookupByLibrary.simpleMessage(
        "Publícalo, dilo, muéstralo.",
      ),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
        "Texto, voz y vídeo; las personas que los crean y los espacios donde conversan.",
      ),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("¿Ya estás en Kyron?"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
        "Al continuar, aceptas nuestros Términos y la Política de privacidad",
      ),
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
        "El inicio de sesión con Google necesita la aplicación móvil",
      ),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google devuelve el inicio de sesión completado a Kyron mediante un enlace que solo Android e iOS pueden abrir. Por eso, en ${a0}, el navegador no tendría adónde volver.\\n\\nSi ya tienes una cuenta de Kyron mediante Google, usa Continuar con correo con esa misma dirección y toca ¿Olvidaste tu contraseña?; te enviaremos un enlace para establecer una.",
      "loginFailed": MessageLookupByLibrary.simpleMessage(
        "No se pudo iniciar sesión. Comprueba tus credenciales.",
      ),
      "email": MessageLookupByLibrary.simpleMessage("Correo electrónico"),
      "password": MessageLookupByLibrary.simpleMessage("Contraseña"),
      "login": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
      "or": MessageLookupByLibrary.simpleMessage("o"),
      "username": MessageLookupByLibrary.simpleMessage("Nombre de usuario"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
        "El nombre de usuario debe estar en minúsculas (a-z, 0-9, _)",
      ),
      "passwordTooShort": MessageLookupByLibrary.simpleMessage(
        "La contraseña es demasiado corta",
      ),
      "continueAction": MessageLookupByLibrary.simpleMessage("Continuar"),
      "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage(
        "Al registrarte, aceptas nuestros",
      ),
      "terms": MessageLookupByLibrary.simpleMessage("Términos"),
      "and": MessageLookupByLibrary.simpleMessage("y"),
      "privacyPolicy": MessageLookupByLibrary.simpleMessage(
        "Política de privacidad",
      ),
      "googleSignIn": MessageLookupByLibrary.simpleMessage(
        "Iniciar sesión con Google",
      ),
      "googleSignUp": MessageLookupByLibrary.simpleMessage(
        "Registrarse con Google",
      ),
      "googleContinue": MessageLookupByLibrary.simpleMessage(
        "Continuar con Google",
      ),
      "byContinuingAgreeTerms": MessageLookupByLibrary.simpleMessage(
        "Al continuar, aceptas nuestros",
      ),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Si Kyron está disponible ahora"),
      "literalwhatThisAppHasBeenDoing": MessageLookupByLibrary.simpleMessage(
        "Qué ha estado haciendo esta app",
      ),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
        "Compartir el registro con soporte",
      ),
      "literalclearCache": MessageLookupByLibrary.simpleMessage("Borrar caché"),
      "literalappVersion": MessageLookupByLibrary.simpleMessage(
        "Versión de la app",
      ),
      "literalreading": MessageLookupByLibrary.simpleMessage("Leyendo…"),
      "literalcheckAgain": MessageLookupByLibrary.simpleMessage(
        "Comprobar de nuevo",
      ),
      "literalkyronDidNotAnswer": MessageLookupByLibrary.simpleMessage(
        "Kyron no respondió",
      ),
      "literalnothingLoggedYet": MessageLookupByLibrary.simpleMessage(
        "Aún no hay registros",
      ),
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Cambiar cámara"),
      "literaltheCameraIsClosed": MessageLookupByLibrary.simpleMessage(
        "La cámara está cerrada",
      ),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Tomar una foto"),
      "literallensNameFaceLens": (Object a0) => "${a0}, lente facial",
      "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
        "No se pudo publicar esa respuesta.",
      ),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
        "No se pudo cargar esta respuesta",
      ),
      "literalthisReplyIsGone": MessageLookupByLibrary.simpleMessage(
        "Esta respuesta ya no existe",
      ),
      "literaladdAPhoto":
          MessageLookupByLibrary.simpleMessage("Agregar una foto"),
      "literaladdAClip":
          MessageLookupByLibrary.simpleMessage("Agregar un clip"),
      "literalstartACommunity": MessageLookupByLibrary.simpleMessage(
        "Crear una comunidad",
      ),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
        "No se pudieron cargar tus comunidades",
      ),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
        "No estás en ninguna comunidad",
      ),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
        "No se pudieron cargar las comunidades",
      ),
      "literalpostInWidgetCommunityName": (Object a0) => "Publicar en ${a0}",
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Escribe algo para ${a0}",
      "literaltagSomeone": MessageLookupByLibrary.simpleMessage(
        "Etiquetar a alguien",
      ),
      "literalcloseWidgetCommunityName": (Object a0) => "¿Cerrar ${a0}?",
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
        "Solo el propietario puede cambiar esto",
      ),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
        "Toca el banner o la imagen para cambiarla",
      ),
      "literalremoveMemberDisplayname": (Object a0) => "¿Eliminar a ${a0}?",
      "literalcouldNotLoadTheMembers": MessageLookupByLibrary.simpleMessage(
        "No se pudieron cargar los miembros",
      ),
      "literalnobodyHereYet": MessageLookupByLibrary.simpleMessage(
        "Todavía no hay nadie aquí",
      ),
      "literalmakeAModerator": MessageLookupByLibrary.simpleMessage(
        "Convertir en moderador",
      ),
      "literalremoveAsModerator": MessageLookupByLibrary.simpleMessage(
        "Quitar como moderador",
      ),
      "literalremoveFromCommunity": MessageLookupByLibrary.simpleMessage(
        "Eliminar de la comunidad",
      ),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
        "No se pudo cargar esta lista",
      ),
      "literalnobodyHasBeenRemoved": MessageLookupByLibrary.simpleMessage(
        "Nadie ha sido eliminado",
      ),
      "literalpostInCommunityName": (Object a0) => "Publicar en ${a0}",
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
        "No se pudo abrir esta comunidad",
      ),
      "literalthisCommunity": MessageLookupByLibrary.simpleMessage(
        "Esta comunidad",
      ),
      "literalshareThisCommunity": MessageLookupByLibrary.simpleMessage(
        "Compartir esta comunidad",
      ),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("Copiar enlace"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("Enlace copiado"),
      "literalleaveCommunityName": (Object a0) => "¿Salir de ${a0}?",
      "literalyouHaveLeftCommunityName": (Object a0) => "Has salido de ${a0}",
      "literaladdAVideo":
          MessageLookupByLibrary.simpleMessage("Agregar un video"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("Agregar un GIF"),
      "literalrecordAVoicePost": MessageLookupByLibrary.simpleMessage(
        "Grabar una publicación de voz",
      ),
      "literalremoveThePoll": MessageLookupByLibrary.simpleMessage(
        "Eliminar la encuesta",
      ),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage(
        "Agregar una encuesta",
      ),
      "literaladdAHashtag": MessageLookupByLibrary.simpleMessage(
        "Agregar un hashtag",
      ),
      "literaldraftSaved": MessageLookupByLibrary.simpleMessage(
        "Borrador guardado",
      ),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("Sin borradores"),
      "literalnothingIsTrendingYet": MessageLookupByLibrary.simpleMessage(
        "Aún no hay tendencias",
      ),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalsendTheLink": MessageLookupByLibrary.simpleMessage(
        "Enviar el enlace",
      ),
      "literalopenTheMailFromKyron": MessageLookupByLibrary.simpleMessage(
        "Abre el correo de Kyron",
      ),
      "literaltapTheLinkInsideIt": MessageLookupByLibrary.simpleMessage(
        "Toca el enlace dentro",
      ),
      "literalsetAPasswordAndCarryOn": MessageLookupByLibrary.simpleMessage(
        "Establece una contraseña y continúa",
      ),
      "literalsendAgainInCooldownS": (Object a0) => "Reenviar en ${a0}s",
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("Reenviar"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
        "No se pudieron cargar tus mensajes",
      ),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("Nada por leer"),
      "literalnoMessagesYet": MessageLookupByLibrary.simpleMessage(
        "Aún no hay mensajes",
      ),
      "literalnothingMuted": MessageLookupByLibrary.simpleMessage(
        "Nada silenciado",
      ),
      "literalnoLikesYet": MessageLookupByLibrary.simpleMessage(
        "Aún no hay me gusta",
      ),
      "literalnoRepliesYet": MessageLookupByLibrary.simpleMessage(
        "Aún no hay respuestas",
      ),
      "literalnoNewFollowers": MessageLookupByLibrary.simpleMessage(
        "No hay nuevos seguidores",
      ),
      "literalnoRepostsYet": MessageLookupByLibrary.simpleMessage(
        "Aún no hay reenvíos",
      ),
      "literalyouAreAllCaughtUp": MessageLookupByLibrary.simpleMessage(
        "Ya estás al día",
      ),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
        "No se pudieron cargar las notificaciones",
      ),
      "literalcoverPhoto":
          MessageLookupByLibrary.simpleMessage("Foto de portada"),
      "literalchooseFromGallery": MessageLookupByLibrary.simpleMessage(
        "Elegir de la galería",
      ),
      "literaluseOneOfOurs": MessageLookupByLibrary.simpleMessage(
        "Usa una de las nuestras",
      ),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
        "Toca para añadir una foto y una portada",
      ),
      "literalnoInterestsYet": MessageLookupByLibrary.simpleMessage(
        "Aún no hay intereses",
      ),
      "literaldiscoverPeople": MessageLookupByLibrary.simpleMessage(
        "Descubrir personas",
      ),
      "literalcancelReply": MessageLookupByLibrary.simpleMessage(
        "Cancelar respuesta",
      ),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
        "No se pudo cargar esta publicación",
      ),
      "literalshareThisProfile": MessageLookupByLibrary.simpleMessage(
        "Compartir este perfil",
      ),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
        "No se pudieron cargar estas publicaciones",
      ),
      "literalyouHaveNotPostedYet": MessageLookupByLibrary.simpleMessage(
        "Aún no has publicado",
      ),
      "literalnoPostsYet": MessageLookupByLibrary.simpleMessage(
        "Aún no hay publicaciones",
      ),
      "literalnothingToLookAtYet": MessageLookupByLibrary.simpleMessage(
        "Aún no hay nada que ver",
      ),
      "literalkeepTyping": MessageLookupByLibrary.simpleMessage(
        "Sigue escribiendo",
      ),
      "literalsearchFailed": MessageLookupByLibrary.simpleMessage(
        "Búsqueda fallida",
      ),
      "literalnothingMatched": MessageLookupByLibrary.simpleMessage(
        "No hay coincidencias",
      ),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "No se pudo cerrar sesión: ${a0}",
      "literalnoDidYet": MessageLookupByLibrary.simpleMessage("Aún no hay DID"),
      "literalpasswordLogin": MessageLookupByLibrary.simpleMessage(
        "Contraseña y acceso",
      ),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
        "Cuentas silenciadas y bloqueadas",
      ),
      "literalfontSize":
          MessageLookupByLibrary.simpleMessage("Tamaño de fuente"),
      "literalpushNotifications": MessageLookupByLibrary.simpleMessage(
        "Notificaciones push",
      ),
      "literaldataSaver":
          MessageLookupByLibrary.simpleMessage("Ahorro de datos"),
      "literalcontactSupport": MessageLookupByLibrary.simpleMessage(
        "Contactar con soporte",
      ),
      "literalsendFeedback": MessageLookupByLibrary.simpleMessage(
        "Enviar comentarios",
      ),
      "literalappLanguage": MessageLookupByLibrary.simpleMessage(
        "Idioma de la app",
      ),
      "literalprimaryLanguage": MessageLookupByLibrary.simpleMessage(
        "Idioma principal",
      ),
      "literalcontentLanguages": MessageLookupByLibrary.simpleMessage(
        "Idiomas del contenido",
      ),
      "literalremoveLanguageEnglishname": (Object a0) => "Eliminar ${a0}",
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Enviado. Es el informe #${a0}.",
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
        "No se puede enviar comentarios ahora mismo",
      ),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
        "Qué hiciste, qué esperabas, qué pasó ",
      ),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Verificación fallida: ${a0}",
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
        "Código de verificación reenviado.",
      ),
      "literalverifyEmail": MessageLookupByLibrary.simpleMessage(
        "Verificar correo electrónico",
      ),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("Reenviar código"),
      "literalremoveThisConversation": MessageLookupByLibrary.simpleMessage(
        "Eliminar esta conversación",
      ),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
        "Silenciado. No recibirás notificaciones.",
      ),
      "literalblockThisAccount": MessageLookupByLibrary.simpleMessage(
        "¿Bloquear esta cuenta?",
      ),
      "literalyouAreSignedOut": MessageLookupByLibrary.simpleMessage(
        "Has cerrado sesión.",
      ),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
        "No se pudo cargar esta conversación",
      ),
      "literalsaySomething": MessageLookupByLibrary.simpleMessage("Di algo"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("Copiar texto"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("No responder"),
      "literalremoveFromSaved": MessageLookupByLibrary.simpleMessage(
        "Quitar de guardados",
      ),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("Activar sonido"),
      "literalturnSoundOff": MessageLookupByLibrary.simpleMessage(
        "Desactivar sonido",
      ),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
        "Ese enlace no se puede abrir aquí.",
      ),
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
        "Ningún navegador en este dispositivo pudo abrir ese enlace.",
      ),
      "literalopenReply":
          MessageLookupByLibrary.simpleMessage("Abrir respuesta"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literalindex1": (Object a0) => "${a0}",
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalgifsAreNotSetUp": MessageLookupByLibrary.simpleMessage(
        "Los GIF no están configurados",
      ),
      "literalcouldNotLoadGifs": MessageLookupByLibrary.simpleMessage(
        "No se pudieron cargar los GIF",
      ),
      "literalnothingFound": MessageLookupByLibrary.simpleMessage(
        "No se encontró nada",
      ),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage(
        "Ese GIF no se pudo descargar.",
      ),
      "literaladdAnInterest": MessageLookupByLibrary.simpleMessage(
        "Agregar un interés",
      ),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
        "No se pudieron cargar las etiquetas de tendencia",
      ),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
        "Ninguna etiqueta de tendencia coincide con eso",
      ),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
        "Ya sigues todas las etiquetas de tendencia",
      ),
      "literalremoveLabel": (Object a0) => "Eliminar ${a0}",
      "literaladdLabelAsATab": (Object a0) => "Agregar ${a0} como pestaña",
      "literalcouldNotSearch": MessageLookupByLibrary.simpleMessage(
        "No se pudo buscar",
      ),
      "literalwhoDoYouWantToTag": MessageLookupByLibrary.simpleMessage(
        "¿A quién quieres etiquetar?",
      ),
      "literalnobodyFound": MessageLookupByLibrary.simpleMessage(
        "No se encontró a nadie",
      ),
      "literalshowPassword": MessageLookupByLibrary.simpleMessage(
        "Mostrar contraseña",
      ),
      "literalhidePassword": MessageLookupByLibrary.simpleMessage(
        "Ocultar contraseña",
      ),
      "literaltranslatePost": MessageLookupByLibrary.simpleMessage(
        "Traducir publicación",
      ),
      "literalcopyPostText": MessageLookupByLibrary.simpleMessage(
        "Copiar texto de la publicación",
      ),
      "literalcopyLinkToPost": MessageLookupByLibrary.simpleMessage(
        "Copiar enlace de la publicación",
      ),
      "literalshowMorePostsLikeThis": MessageLookupByLibrary.simpleMessage(
        "Mostrar más publicaciones como esta",
      ),
      "literalnotInterestedInThis": MessageLookupByLibrary.simpleMessage(
        "No me interesa esto",
      ),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
        "La oculta y nos indica mostrar menos contenido similar",
      ),
      "literalhideThisPost": MessageLookupByLibrary.simpleMessage(
        "Ocultar esta publicación",
      ),
      "literalmuteThisThread": MessageLookupByLibrary.simpleMessage(
        "Silenciar este hilo",
      ),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
        "Dejar de ver esta publicación y sus respuestas",
      ),
      "literalmuteWordsOrTags": MessageLookupByLibrary.simpleMessage(
        "Silenciar palabras o etiquetas",
      ),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
        "Vistas, me gusta, guardados y comentarios",
      ),
      "literalwhoCanReply": MessageLookupByLibrary.simpleMessage(
        "Quién puede responder",
      ),
      "literaldeletePost": MessageLookupByLibrary.simpleMessage(
        "Eliminar publicación",
      ),
      "literalmuteAuthor": (Object a0) => "Silenciar a ${a0}",
      "literalblockAuthor": (Object a0) => "Bloquear a ${a0}",
      "literalreportPost": MessageLookupByLibrary.simpleMessage(
        "Denunciar publicación",
      ),
      "literalreportAuthor": (Object a0) => "Denunciar a ${a0}",
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
        "No se pudo enviar. Inténtalo de nuevo.",
      ),
      "literalblockAuthor2": (Object a0) => "¿Bloquear a ${a0}?",
      "literalshowResults": MessageLookupByLibrary.simpleMessage(
        "Mostrar resultados",
      ),
      "literallabelDate": (Object a0) => "\\${a0} fecha",
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Compartir vía…"),
      "literalhandItToAnotherApp": MessageLookupByLibrary.simpleMessage(
        "Abrir con otra app",
      ),
      "literalshareWithAQuote": MessageLookupByLibrary.simpleMessage(
        "Compartir con cita",
      ),
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
        "Publicarlo con tus propias palabras arriba",
      ),
      "literalsavedPosts": MessageLookupByLibrary.simpleMessage(
        "Publicaciones guardadas",
      ),
      "literallikedPosts": MessageLookupByLibrary.simpleMessage(
        "Publicaciones que te gustaron",
      ),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Historias, ${a0} elementos",
      "literalwhatYouPostIsYours": MessageLookupByLibrary.simpleMessage(
        "Lo que publicas es tuyo",
      ),
      "literalwhatKyronKeeps": MessageLookupByLibrary.simpleMessage(
        "Lo que Kyron conserva",
      ),
      "literalhowToBehave": MessageLookupByLibrary.simpleMessage(
        "Cómo comportarse",
      ),
      "literalcloseTabLabel": (Object a0) => "Cerrar ${a0}",
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("1 página abierta"),
      "literalcountPagesOpen": (Object a0) => "${a0} páginas abiertas",
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Detener carga"),
      "literalshareThisPage": MessageLookupByLibrary.simpleMessage(
        "Compartir esta página",
      ),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Ninguna aplicación en este dispositivo abre enlaces ${a0}.",
      "literalcloseTheBrowser": MessageLookupByLibrary.simpleMessage(
        "Cerrar el navegador",
      ),
      "literalcloseAllPages": MessageLookupByLibrary.simpleMessage(
        "Cerrar todas las páginas",
      ),
      "literalremoveThisPoll": MessageLookupByLibrary.simpleMessage(
        "Eliminar esta encuesta",
      ),
      "literalremoveThisAnswer": MessageLookupByLibrary.simpleMessage(
        "Eliminar esta respuesta",
      ),
      "literalstartRecording": MessageLookupByLibrary.simpleMessage(
        "Iniciar grabación",
      ),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Volver a grabar"),
      "home": MessageLookupByLibrary.simpleMessage("Inicio"),
      "explore": MessageLookupByLibrary.simpleMessage("Explorar"),
      "communities": MessageLookupByLibrary.simpleMessage("Comunidades"),
      "messages": MessageLookupByLibrary.simpleMessage("Mensajes"),
      "languages": MessageLookupByLibrary.simpleMessage("Idiomas"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
        "Selecciona el idioma de la interfaz de la aplicación.",
      ),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
        "Selecciona tu idioma preferido para las traducciones de tu feed.",
      ),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
        "Selecciona los idiomas que quieres incluir en tus feeds. Si no eliges ninguno, se mostrarán todos los idiomas.",
      ),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
        "Las palabras de Kyron todavía se están traduciendo, por lo que la mayoría de las pantallas seguirán en inglés por ahora.",
      ),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
        "Encuentra una en Descubrir o crea la tuya.",
      ),
      "messagesCaughtUp": MessageLookupByLibrary.simpleMessage(
        "Todas las conversaciones están al día.",
      ),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
        "Abre el perfil de alguien y toca Mensaje para iniciar una conversación.",
      ),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
        "Cuando a alguien le gusta una de tus publicaciones, aparecerá aquí.",
      ),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
        "Las respuestas a tus publicaciones aparecerán aquí.",
      ),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
        "Las personas que te siguen aparecerán aquí.",
      ),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
        "Cuando alguien comparte de nuevo una publicación tuya, aparecerá aquí.",
      ),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
        "Los Me gusta, las respuestas y los nuevos seguidores aparecerán aquí cuando lleguen.",
      ),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("Obtener ayuda"),
      "send": MessageLookupByLibrary.simpleMessage("Enviar"),
      "close": MessageLookupByLibrary.simpleMessage("Cerrar"),
      "search": MessageLookupByLibrary.simpleMessage("Buscar"),
      "settings": MessageLookupByLibrary.simpleMessage("Ajustes"),
      "menu": MessageLookupByLibrary.simpleMessage("Menú"),
      "clear": MessageLookupByLibrary.simpleMessage("Borrar"),
      "manage": MessageLookupByLibrary.simpleMessage("Administrar"),
      "join": MessageLookupByLibrary.simpleMessage("Unirse"),
      "video": MessageLookupByLibrary.simpleMessage("Vídeo"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
        "Las publicaciones todavía no incluyen un idioma, por lo que esto aún no filtra tu feed. Tu elección se conservará para cuando lo incluyan.",
      ),
      "addMoreLanguages": MessageLookupByLibrary.simpleMessage(
        "Añadir más idiomas…",
      ),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
        "La traducción todavía no está disponible. Hoy nada de tu feed se traduce; esta elección se conservará para cuando lo esté.",
      ),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
        "Kyron todavía está empezando. La forma más rápida de contactar con alguien que pueda resolver un problema es abrir una incidencia. Incluye qué estabas haciendo y qué ocurrió.",
      ),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
        "Todavía no hay una bandeja de soporte en la aplicación, así que esta pantalla te dirige al lugar que realmente se supervisa en vez de a un formulario que no llega a ninguna parte.",
      ),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("¿Para qué sirve? (opcional)"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
        "Deberás iniciar sesión de nuevo para volver a tu cuenta.",
      ),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage(
        "Nueva dirección de correo electrónico",
      ),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Nueva contraseña"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Confirmar contraseña"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("En una línea"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Qué pasó"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage(
        "Omitir",
      ),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage(
        "Finalizar",
      ),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Ida y vuelta"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("VERIFICACIÓN DE TOKEN"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Intentar de nuevo"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Intentar de nuevo"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
        "Comenzar una transmisión ahora te pondría en una sala que nadie podría",
      ),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Crear una comunidad"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("¿Para qué sirve? (opcional)"),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Cerrándola"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("de vuelta."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("de vuelta desde esta lista."),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("únete primero"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("Próximamente"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Publicando como tú"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage(
        "Ahora mismo",
      ),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage(
        "Tema 1",
      ),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("ya está en camino."),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("tenga algo."),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("ESPECTADORES POR DÍA"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("esta publicación"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage("¿Algo que añadir? (opcional)"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Tu cuenta"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Confirmar contraseña"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("Ahora no"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("publicar en esta comunidad"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage(
        "propio.",
      ),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage(
        "Intentar de nuevo",
      ),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage(
        "Para ti",
      ),
      "audit_google_button_not_bbd76526": MessageLookupByLibrary.simpleMessage(
        ", no",
      ),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("¿Me estoy moviendo?"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Activar sonido"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Desactivar sonido"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage(
        "Para ti",
      ),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Tus pestañas"),
      "audit_media_tray_alt_784030d4": MessageLookupByLibrary.simpleMessage(
        "+ ALT",
      ),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Intentar de nuevo"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Símbolo (!@#…)"),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("no se pudo cargar"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("esta publicación"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("De una cuenta"),
      "audit_skeleton_loading_18e82bcc": MessageLookupByLibrary.simpleMessage(
        "Cargando…",
      ),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87": MessageLookupByLibrary.simpleMessage(
        "Publicando…",
      ),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Tu historia"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Copiar enlace de la historia"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage(
        "hace 3 h",
      ),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
        "Tu cuenta, tus publicaciones y lo que pulsas, así que",
      ),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Añadir un tema"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Comunidades"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Configuración"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Apariencia"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Idioma"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Cuenta"),
      "ui_content_display": MessageLookupByLibrary.simpleMessage(
        "Contenido y visualización",
      ),
      "ui_app_device": MessageLookupByLibrary.simpleMessage(
        "Aplicación y dispositivo",
      ),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Términos"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Privacidad"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Ayuda"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Comentarios"),
      "ui_decentralized_id": MessageLookupByLibrary.simpleMessage(
        "ID descentralizado",
      ),
      "ui_find_people_on_kyron": MessageLookupByLibrary.simpleMessage(
        "Encuentra personas en Kyron",
      ),
      "ui_search_everything_posted": MessageLookupByLibrary.simpleMessage(
        "Buscar todo lo publicado",
      ),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
        "Buscar por usuario o nombre visible.",
      ),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
        "Palabras, o un filtro: una cuenta, un rango de fechas o lo que lleva una publicación.",
      ),
      "ui_two_characters_or_more": MessageLookupByLibrary.simpleMessage(
        "Dos caracteres o más.",
      ),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
        "Ninguna publicación coincide con esos filtros.",
      ),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Borrar"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Filtros"),
      "ui_post_text_copied": MessageLookupByLibrary.simpleMessage(
        "Texto de la publicación copiado",
      ),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("Enlace copiado"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
        "Anotado. Esto ayuda a determinar lo que se te muestra.",
      ),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
        "Oculto. Te mostraremos menos cosas así.",
      ),
      "ui_post_hidden":
          MessageLookupByLibrary.simpleMessage("Publicación oculta"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("Hilo silenciado"),
      "ui_post_deleted": MessageLookupByLibrary.simpleMessage(
        "Publicación eliminada",
      ),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
        "Se elimina de tu perfil y del feed de todos los demás. Las respuestas a esta también se eliminan.",
      ),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
        "Ninguno de los dos verá al otro en Kyron, y cualquier seguimiento entre ustedes se elimina. No se les notifica.",
      ),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
        "Dejarás de ver sus publicaciones. No se les notifica.",
      ),
      "ui_about_terms_of_service": MessageLookupByLibrary.simpleMessage(
        "Términos de servicio",
      ),
      "ui_about_privacy_policy": MessageLookupByLibrary.simpleMessage(
        "Política de privacidad",
      ),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
        "Tu perfil e información de contacto",
      ),
      "ui_settings_security": MessageLookupByLibrary.simpleMessage(
        "Ajustes de seguridad",
      ),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
        "A quién has silenciado o bloqueado",
      ),
      "ui_settings_content_display": MessageLookupByLibrary.simpleMessage(
        "Contenido y visualización",
      ),
      "ui_settings_app_device": MessageLookupByLibrary.simpleMessage(
        "Aplicación y dispositivo",
      ),
      "ui_settings_data_saver": MessageLookupByLibrary.simpleMessage(
        "Ahorro de datos",
      ),
      "ui_settings_language_detail": MessageLookupByLibrary.simpleMessage(
        "Elige tu idioma",
      ),
      "ui_settings_notifications_detail": MessageLookupByLibrary.simpleMessage(
        "Preferencias de notificación",
      ),
      "ui_settings_help_articles": MessageLookupByLibrary.simpleMessage(
        "Explorar artículos de ayuda",
      ),
      "ui_settings_team_help": MessageLookupByLibrary.simpleMessage(
        "Recibe ayuda de nuestro equipo",
      ),
      "ui_settings_feedback_detail": MessageLookupByLibrary.simpleMessage(
        "Dinos qué piensas",
      ),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
        "No se pudo cargar tu perfil",
      ),
      "ui_search_people":
          MessageLookupByLibrary.simpleMessage("Buscar personas"),
      "ui_search_posts": MessageLookupByLibrary.simpleMessage(
        "Buscar publicaciones",
      ),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("esta publicación"),
      "authorPostsHidden": (Object a0) => "No verás publicaciones de ${a0}",
      "authorBlocked": (Object a0) => "${a0} bloqueado",
      "nothingMatchesQuery": (Object a0) =>
          "Nada en Kyron coincide con \"${a0}\"",
      "repliesPolicy": (Object a0) => "Respuestas: ${a0}",
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Preferencias"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
        "Claro, oscuro, o lo que tenga configurado el teléfono",
      ),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Legal"),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("Diagnósticos"),
      "ui_saved_posts": MessageLookupByLibrary.simpleMessage(
        "Publicaciones guardadas",
      ),
      "ui_liked_posts": MessageLookupByLibrary.simpleMessage(
        "Publicaciones que te gustaron",
      ),
      "ui_nothing_saved_yet": MessageLookupByLibrary.simpleMessage(
        "Nada guardado todavía",
      ),
      "ui_no_likes_yet": MessageLookupByLibrary.simpleMessage(
        "Aún no hay 'me gusta'",
      ),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
        "Toca el icono de archivo en cualquier publicación para guardarla aquí. Solo tú puedes ver lo que guardas.",
      ),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
        "Las publicaciones que te gustan aparecen aquí, las más recientes primero.",
      ),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
        "No se pudieron cargar tus publicaciones guardadas",
      ),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
        "No se pudieron cargar tus publicaciones marcadas con 'me gusta'",
      ),
      "feedTagDetail": (Object a0) =>
          "Aún no se ha publicado nada bajo #${a0}.",
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
        "Nada de las personas que sigues",
      ),
      "ui_feed_videos_empty": MessageLookupByLibrary.simpleMessage(
        "Aún no hay videos",
      ),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Nada aquí todavía"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
        "Sigue a algunas cuentas y sus publicaciones aparecerán aquí.",
      ),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
        "Las publicaciones que incluyan un clip aparecerán aquí.",
      ),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
        "Las publicaciones aparecerán aquí a medida que las personas las publiquen.",
      ),
      "ui_could_not_load_feed": MessageLookupByLibrary.simpleMessage(
        "No se pudo cargar tu feed",
      ),
      "ui_share_this_post": MessageLookupByLibrary.simpleMessage(
        "Compartir esta publicación",
      ),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
        "Personas distintas, no aperturas",
      ),
      "analytics_engagement":
          MessageLookupByLibrary.simpleMessage("Interacción"),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Publicada"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Espectadores"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Me gusta"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Comentarios"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Guardados"),
      "analytics_no_viewers_yet": MessageLookupByLibrary.simpleMessage(
        "Todavía no hay espectadores",
      ),
      "analytics_viewers_per_day": MessageLookupByLibrary.simpleMessage(
        "ESPECTADORES POR DÍA",
      ),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
        "Nadie ha abierto esta publicación todavía.",
      ),
      "reply_who_can_reply": MessageLookupByLibrary.simpleMessage(
        "¿Quién puede responder?",
      ),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
        "Cualquiera puede verla, republicarla y citarla.",
      ),
      "reply_anyone": MessageLookupByLibrary.simpleMessage(
        "Cualquiera puede interactuar",
      ),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
        "Cualquiera en Kyron puede responder a esta publicación.",
      ),
      "reply_followers": MessageLookupByLibrary.simpleMessage(
        "Personas que te siguen",
      ),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
        "Solo las personas que te siguen pueden responder a esta publicación.",
      ),
      "reply_mentioned": MessageLookupByLibrary.simpleMessage(
        "Personas que mencionas",
      ),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
        "Solo las personas que @mencionas en esta publicación pueden responder.",
      ),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("Nadie puede responder"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
        "Las respuestas están desactivadas. Tú todavía puedes responder.",
      ),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("Para ti"),
      "interest_following": MessageLookupByLibrary.simpleMessage("Siguiendo"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Vídeos"),
      "interest_your_tabs":
          MessageLookupByLibrary.simpleMessage("Tus pestañas"),
      "interest_drag_to_reorder": MessageLookupByLibrary.simpleMessage(
        "Arrastra para reordenar",
      ),
      "interest_add": MessageLookupByLibrary.simpleMessage("Añadir un interés"),
      "interest_trending_now": MessageLookupByLibrary.simpleMessage(
        "Tendencias actuales",
      ),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
        "La barra admite como máximo cinco pestañas. Quita una para añadir otra.",
      ),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
        "Los hashtags aparecerán aquí cuando la gente empiece a usarlos.",
      ),
      "composer_placeholder_rattling": MessageLookupByLibrary.simpleMessage(
        "¿Qué te ronda por la cabeza?",
      ),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
        "Di algo que solo tú puedas decir…",
      ),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
        "Comparte una opinión fuerte (o una suave)",
      ),
      "composer_placeholder_signal": MessageLookupByLibrary.simpleMessage(
        "Esta es tu señal: envíala",
      ),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
        "Escribe, habla o piensa en voz alta",
      ),
      "profile_tap_to_change": MessageLookupByLibrary.simpleMessage(
        "Toca para cambiar",
      ),
      "profile_display_name": MessageLookupByLibrary.simpleMessage(
        "Nombre visible",
      ),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Biografía"),
      "profile_location": MessageLookupByLibrary.simpleMessage("Ubicación"),
      "profile_website": MessageLookupByLibrary.simpleMessage("Sitio web"),
      "translation_description": MessageLookupByLibrary.simpleMessage(
        "Las palabras propias de Kyron todavía se están traduciendo, así que la mayoría de las pantallas siguen en inglés. Por ahora se traducen las partes de la interfaz que dibuja Flutter, las fechas y los números, y la dirección de diseño para idiomas de derecha a izquierda.",
      ),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
        "Usar el modo claro u oscuro del teléfono",
      ),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Siempre claro"),
      "theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Siempre oscuro"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
        "Un modo oscuro más suave, azul grisáceo en lugar de negro",
      ),
      "theme_system": MessageLookupByLibrary.simpleMessage("Sistema"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Claro"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Oscuro"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Atenuado"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Me gusta"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Compartir"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Unido"),
      "ui_join": MessageLookupByLibrary.simpleMessage("Unirse"),
      "ui_turn_sound_on":
          MessageLookupByLibrary.simpleMessage("Activar sonido"),
      "ui_turn_sound_off": MessageLookupByLibrary.simpleMessage(
        "Desactivar sonido",
      ),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Pausar"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Reproducir"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("De una cuenta"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Publicado entre"),
      "ui_after": MessageLookupByLibrary.simpleMessage("Después"),
      "ui_before": MessageLookupByLibrary.simpleMessage("Antes"),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Con"),
      "create_text_post": MessageLookupByLibrary.simpleMessage(
        "Publicación de texto",
      ),
      "create_voice_post": MessageLookupByLibrary.simpleMessage(
        "Publicación de voz",
      ),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("Lente de RA"),
      "create_go_live":
          MessageLookupByLibrary.simpleMessage("Transmitir en vivo"),
      "voice_record_post": MessageLookupByLibrary.simpleMessage(
        "Grabar una publicación de voz",
      ),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Grabando…"),
      "voice_ready_attach": MessageLookupByLibrary.simpleMessage(
        "Listo para adjuntar",
      ),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Detener"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Adjuntar"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
        "Cierra el editor con algo escrito y se te ofrecerá un borrador.",
      ),
      "draft_poll_empty": MessageLookupByLibrary.simpleMessage(
        "Una encuesta sin pregunta todavía",
      ),
      "draft_quote_empty": MessageLookupByLibrary.simpleMessage(
        "Una cita sin texto todavía",
      ),
      "draft_nothing_empty": MessageLookupByLibrary.simpleMessage(
        "Todavía no hay nada escrito",
      ),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Ahora mismo"),
      "draft_minutes_ago": MessageLookupByLibrary.simpleMessage(
        "Hace {minutes} minutos",
      ),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("Hace {hours} horas"),
      "draft_days_ago":
          MessageLookupByLibrary.simpleMessage("Hace {days} días"),
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("Respondiste"),
      "dmReplied": (Object a0) => "$a0 respondió",
      "ui_dm_attach": MessageLookupByLibrary.simpleMessage("Añadir al mensaje"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Mensaje nuevo"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Aún no se ha dicho nada. Un saludo es un buen comienzo."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Saludar"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Mensajes nuevos"),
      "dmTyping": (Object a0) => "$a0 está escribiendo",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Quitar tu reacción"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Alguien"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Mensaje"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("Archivo adjunto"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Este mensaje no se puede leer en este dispositivo."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Mensaje cifrado"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "Los mensajes están cifrados de extremo a extremo"),
      "ui_dm_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Sin cifrado de extremo a extremo"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Enviado"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Visto"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Enviando…"),
      "ui_dm_take_photo":
          MessageLookupByLibrary.simpleMessage("Hacer una foto"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Más opciones"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("Guardar en el dispositivo"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Compartir"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Guardando…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Guardado en tus fotos"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "No se pudo guardar. Inténtalo de nuevo."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Permite que Kyron añada a tus fotos para guardar esto."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Todos los sistemas operativos"),
      "ui_status_uptime":
          MessageLookupByLibrary.simpleMessage("Disponibilidad"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Últimos 60 días"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("Hace 60 días"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Hoy"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database":
          MessageLookupByLibrary.simpleMessage("Base de datos"),
      "ui_status_auth":
          MessageLookupByLibrary.simpleMessage("Inicio de sesión"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Incidentes recientes"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Ningún incidente en los últimos 60 días."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("En curso"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Sin datos"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Detalles"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron se comprueba cada 5 minutos mientras está en marcha. Un día gris no tuvo comprobaciones."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "El historial de disponibilidad aún no está disponible."),
      "ui_status_degraded": MessageLookupByLibrary.simpleMessage(
          "Algunos sistemas tienen problemas"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Grabar una nota de voz"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Lista para enviar"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Ese mensaje ya no está aquí."),
      "ui_dm_quote_open": MessageLookupByLibrary.simpleMessage("Ir al mensaje"),
      "ui_dm_quote_voice": MessageLookupByLibrary.simpleMessage("Nota de voz"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Le gusta al autor"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Agregar una foto o un clip"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Multimedia"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Notas de voz"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Chat"),
      "ui_dm_info_wallpaper":
          MessageLookupByLibrary.simpleMessage("Fondo de pantalla"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Silenciar notificaciones"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Dejar de recibir notificaciones de esta conversación"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "Ya no pueden enviarte mensajes"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Ninguno"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Foto"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("Ya no está silenciada."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "No se pudo eliminar. Inténtalo de nuevo."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Perfil"),
      "ui_dm_unmute":
          MessageLookupByLibrary.simpleMessage("Dejar de silenciar"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Aquí aparecen las fotos y los clips que compartes."),
      "ui_dm_info_see_all": MessageLookupByLibrary.simpleMessage("Ver todo"),
      "ui_dm_media_tab": MessageLookupByLibrary.simpleMessage("Fotos y clips"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("Así se verá tu chat."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Se ve bien."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Niebla"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Atardecer"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Salvia"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Arena"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Puntos"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("Aplicar"),
      "ui_dm_wallpaper_current": MessageLookupByLibrary.simpleMessage("Actual"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Enviar sin la vista previa"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Buscar"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Publicar"),
      "ui_share_note":
          MessageLookupByLibrary.simpleMessage("Escribe un mensaje…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Enviar"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Enviado"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("Enviado, pero no a todos."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "No se pudo enviar. Inténtalo de nuevo."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Seguidor"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Filtro"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Todos"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("No leídos"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Sin respuesta"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Ocultos"),
      "ui_dm_hidden_none": MessageLookupByLibrary.simpleMessage("Nada oculto"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Las conversaciones que quitas de tu lista esperan aquí, por si las quieres recuperar."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Pasa a Ocultos. La otra persona conserva la suya, y vuelve si alguno de los dos escribe de nuevo."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Recuperar"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("De vuelta en tu lista."),
      "ui_dm_search_none": MessageLookupByLibrary.simpleMessage(
          "Ninguna conversación coincide."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Nada te espera"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Todas las conversaciones terminan con tu palabra."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Foto"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Fotos"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Vídeo"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Aún no hay mensajes"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Tú:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Ayer"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Mensajes"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Ajustes de mensajes"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("Privacidad"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Confirmaciones de lectura"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Si lo desactivas, los demás no verán cuándo has leído sus mensajes, y tú no verás cuándo han leído los tuyos."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Mostrar cuando escribes"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "La persona a la que escribes ve que estás escribiendo."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Vistas previas de enlaces"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Tu teléfono abre el enlace que envías para crear la vista previa, así que el sitio ve la petición de tu teléfono. El servidor de Kyron nunca ve el enlace."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Notificaciones de mensajes"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Los mensajes están cifrados de extremo a extremo. Kyron no puede leerlos, y nada de aquí lo cambia."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("Para:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Recientes"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Personas"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Nadie con ese nombre."),
      "ui_push_test": MessageLookupByLibrary.simpleMessage(
          "Enviar una notificación de prueba"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "El servidor de Kyron aún no está configurado para enviar notificaciones, así que no puede llegar ninguna. El problema es nuestro, no de tu teléfono."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Este teléfono no está registrado para notificaciones. Comprueba que las notificaciones de Kyron estén permitidas en los ajustes del teléfono e inténtalo de nuevo."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "No se pudo entregar la notificación a este teléfono. Inténtalo de nuevo en un minuto."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Enviada. Debería llegar en unos segundos."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Las notificaciones funcionan."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Aún no hay publicaciones"),
      "ui_community_new":
          MessageLookupByLibrary.simpleMessage("Comunidad nueva"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Nombre"),
      "ui_community_address_hint": MessageLookupByLibrary.simpleMessage(
          "Su dirección se crea a partir del nombre."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("La gente la encontrará en"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Serás su propietario. Una imagen, un banner y moderadores se pueden añadir desde su página cuando exista."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Inicio"),
      "ui_community_in_home": MessageLookupByLibrary.simpleMessage(
          "Publicaciones de comunidades en Inicio"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Las publicaciones de tus comunidades también aparecen en Inicio. Desactivado, se quedan aquí en Comunidades, donde cada una muestra lo que hay de nuevo."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Tu lista"),
      "ui_community_counts": MessageLookupByLibrary.simpleMessage(
          "Número de publicaciones nuevas"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Muestra cuántas publicaciones son nuevas en cada comunidad desde la última vez que la abriste."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Comunidades que diriges"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Aquí aparecen las comunidades que creas o moderas."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("Propietario"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Moderador"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Publicaciones nuevas"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Las que diriges"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Ajustes de comunidades"),
      "ui_community_discover":
          MessageLookupByLibrary.simpleMessage("Descubrir"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("Ninguna comunidad coincide."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Nada nuevo"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Cada comunidad está como la dejaste."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("Aún no diriges ninguna"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("No queda nada a lo que unirse"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Estás en todas las comunidades de Kyron. Crea otra."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Prueba otra palabra, o crea una comunidad con ese nombre."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Escribir una publicación"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("Miembros:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Publicado"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Ver"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Abrir"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("En línea"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Mostrar cuando estás en línea"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Las personas a las que escribes ven un punto verde mientras tienes Kyron abierto. Si lo desactivas, tú tampoco verás el suyo."),
      "ui_explore_search": MessageLookupByLibrary.simpleMessage(
          "Buscar personas y publicaciones"),
      "ui_explore_communities":
          MessageLookupByLibrary.simpleMessage("Comunidades a las que unirte"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Aún no hay nada que ver"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Las fotos y los clips que publique la gente aparecerán aquí."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Seguir"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("Eliminar cuenta"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Esto elimina tu cuenta de Kyron de forma permanente. No se puede deshacer."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Tu perfil, publicaciones, respuestas, me gusta y republicaciones"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Tus mensajes, incluidos los que enviaste a otras personas, y las fotos y notas de voz que contienen"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Tus seguidores, las personas a las que sigues y tu configuración"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Las comunidades que creaste pasan al moderador o miembro con más antigüedad. Si no queda nadie más, se cierra."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("¿Eliminar tu cuenta?"),
      "ui_delete_account_confirm_detail":
          MessageLookupByLibrary.simpleMessage("No podrás recuperar nada."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("Se eliminó tu cuenta."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Cuenta eliminada"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Esta cuenta se eliminó, así que ya no se pueden enviar mensajes aquí."),
    };

final messageLookup = MessageLookup();
