import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es';
  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      'about': MessageLookupByLibrary.simpleMessage('Acerca de'),
      'addAnAnswer':
          MessageLookupByLibrary.simpleMessage('Añadir una respuesta'),
      'agreeAndContinue': MessageLookupByLibrary.simpleMessage(
        'Aceptar y continuar',
      ),
      'answerNumber': (Object i) => 'Respuesta $i',
      'arLens': MessageLookupByLibrary.simpleMessage('Lente de RA'),
      'attachSystemLog': MessageLookupByLibrary.simpleMessage(
        'Adjuntar el registro del sistema',
      ),
      'aWordPhraseOrTag': MessageLookupByLibrary.simpleMessage(
        'Una palabra, frase o #etiqueta',
      ),
      'block': MessageLookupByLibrary.simpleMessage('Bloquear'),
      'blockAuthor': (Object author) => '¿Bloquear a $author?',
      'buildDetailsCopied': MessageLookupByLibrary.simpleMessage(
        'Detalles de la compilación copiados',
      ),
      'bullet': MessageLookupByLibrary.simpleMessage('•'),
      'cancel': MessageLookupByLibrary.simpleMessage('Cancelar'),
      'change': MessageLookupByLibrary.simpleMessage('Cambiar'),
      'changeEmail': MessageLookupByLibrary.simpleMessage('Cambiar correo'),
      'checkKyronReachable': MessageLookupByLibrary.simpleMessage(
        'Comprobar si Kyron está accesible',
      ),
      'checkEmailConfirm': MessageLookupByLibrary.simpleMessage(
        'Revisa tu correo para confirmar tu cuenta.',
      ),
      'closeCommunity': (Object communityName) => '¿Cerrar $communityName?',
      'closeIt': MessageLookupByLibrary.simpleMessage('Cerrar'),
      'closeThisCommunity': MessageLookupByLibrary.simpleMessage(
        'Cerrar esta comunidad',
      ),
      'confirmPassword': MessageLookupByLibrary.simpleMessage(
        'Confirmar contraseña',
      ),
      'contactSupport': MessageLookupByLibrary.simpleMessage(
        'Contactar con soporte',
      ),
      'continueWithEmail': MessageLookupByLibrary.simpleMessage(
        'Continuar con correo',
      ),
      'copy': MessageLookupByLibrary.simpleMessage('Copiar'),
      'copyReportInstead': MessageLookupByLibrary.simpleMessage(
        'Copiar informe en su lugar',
      ),
      'couldNotOpenGoogleSignIn': (Object error) =>
          'No se pudo abrir el inicio de sesión con Google. $error',
      'couldNotSignOut': (Object error) =>
          'No se pudo cerrar la sesión: $error',
      'couldNotTakePicture': MessageLookupByLibrary.simpleMessage(
        'No se pudo tomar esa foto.',
      ),
      'create': MessageLookupByLibrary.simpleMessage('Crear'),
      'createAccount': MessageLookupByLibrary.simpleMessage('Crear cuenta'),
      'createYourAccount':
          MessageLookupByLibrary.simpleMessage('Crea tu cuenta'),
      'createYourProfile':
          MessageLookupByLibrary.simpleMessage('Crea tu perfil'),
      'delete': MessageLookupByLibrary.simpleMessage('Eliminar'),
      'deleteThisComment': MessageLookupByLibrary.simpleMessage(
        '¿Eliminar este comentario?',
      ),
      'deleteThisPost': MessageLookupByLibrary.simpleMessage(
        '¿Eliminar esta publicación?',
      ),
      'describeAttachment': MessageLookupByLibrary.simpleMessage(
        'Describir este adjunto',
      ),
      'description': MessageLookupByLibrary.simpleMessage('Descripción'),
      'didCopied': MessageLookupByLibrary.simpleMessage(
        'DID copiado al portapapeles',
      ),
      'done': MessageLookupByLibrary.simpleMessage('Listo'),
      'drafts': MessageLookupByLibrary.simpleMessage('Borradores'),
      'editProfile': MessageLookupByLibrary.simpleMessage('Editar perfil'),
      'emailNotifications': MessageLookupByLibrary.simpleMessage(
        'Notificaciones por correo',
      ),
      'faceTrackingUnavailable': MessageLookupByLibrary.simpleMessage(
        'El seguimiento facial no está disponible en este dispositivo.',
      ),
      'followers': MessageLookupByLibrary.simpleMessage('Seguidores'),
      'following': MessageLookupByLibrary.simpleMessage('Siguiendo'),
      'forgotPassword': MessageLookupByLibrary.simpleMessage(
        '¿Olvidaste tu contraseña?',
      ),
      'guidesAndAnswers': MessageLookupByLibrary.simpleMessage(
        'Guías y respuestas a preguntas comunes',
      ),
      'handle': MessageLookupByLibrary.simpleMessage('nombre de usuario'),
      'helpCentre': MessageLookupByLibrary.simpleMessage('Centro de ayuda'),
      'helpAndSupport': MessageLookupByLibrary.simpleMessage('Ayuda y soporte'),
      'inOneLine': MessageLookupByLibrary.simpleMessage('En una línea'),
      'itDisappearsForBoth': MessageLookupByLibrary.simpleMessage(
        'Desaparece para ambos.',
      ),
      'itWillBeRemoved': MessageLookupByLibrary.simpleMessage(
        'Se eliminará del hilo.',
      ),
      'keepEditing': MessageLookupByLibrary.simpleMessage('Seguir editando'),
      'kyron': MessageLookupByLibrary.simpleMessage('Kyron'),
      'lagosDesign': MessageLookupByLibrary.simpleMessage('Diseño Lagos'),
      'leave': MessageLookupByLibrary.simpleMessage('Salir'),
      'leaveCommunity': (Object communityName) => '¿Salir de $communityName?',
      'letBackIn': MessageLookupByLibrary.simpleMessage('Permitir volver'),
      'loadMore': MessageLookupByLibrary.simpleMessage('Cargar más'),
      'logCleared': MessageLookupByLibrary.simpleMessage('Registro borrado'),
      'logCopied': MessageLookupByLibrary.simpleMessage('Registro copiado'),
      'logIn': MessageLookupByLibrary.simpleMessage('Iniciar sesión'),
      'logOut': MessageLookupByLibrary.simpleMessage('Cerrar sesión'),
      'logOutQuestion': MessageLookupByLibrary.simpleMessage('¿Cerrar sesión?'),
      'message': MessageLookupByLibrary.simpleMessage('Mensaje'),
      'mute': MessageLookupByLibrary.simpleMessage('Silenciar'),
      'mutedAndBlocked': MessageLookupByLibrary.simpleMessage(
        'Silenciados y bloqueados',
      ),
      'mutedWordsAndTags': MessageLookupByLibrary.simpleMessage(
        'Palabras y etiquetas silenciadas',
      ),
      'name': MessageLookupByLibrary.simpleMessage('Nombre'),
      'nameScreen': MessageLookupByLibrary.simpleMessage('Pantalla <nombre>'),
      'newEmailAddress': MessageLookupByLibrary.simpleMessage(
        'Nueva dirección de correo',
      ),
      'newPassword': MessageLookupByLibrary.simpleMessage('Nueva contraseña'),
      'newPost': MessageLookupByLibrary.simpleMessage('Nueva publicación'),
      'nothingToCopy': MessageLookupByLibrary.simpleMessage('Nada que copiar'),
      'notifications': MessageLookupByLibrary.simpleMessage('Notificaciones'),
      'notNow': MessageLookupByLibrary.simpleMessage('Ahora no'),
      'notSentTapRetry': MessageLookupByLibrary.simpleMessage(
        'No se envió. Toca para reintentar',
      ),
      'openInBrowser': MessageLookupByLibrary.simpleMessage(
        'Abrir en el navegador',
      ),
      'pageNotFound':
          MessageLookupByLibrary.simpleMessage('Página no encontrada'),
      'pickYourInterests': MessageLookupByLibrary.simpleMessage(
        'Elige tus intereses',
      ),
      'post': MessageLookupByLibrary.simpleMessage('Publicar'),
      'postAnalytics': MessageLookupByLibrary.simpleMessage(
        'Estadísticas de la publicación',
      ),
      'postInCommunity': (Object communityName) => 'Publicar en $communityName',
      'postTextCopied': MessageLookupByLibrary.simpleMessage(
        'Texto de la publicación copiado',
      ),
      'profileUpdated':
          MessageLookupByLibrary.simpleMessage('Perfil actualizado'),
      'pushNotifications': MessageLookupByLibrary.simpleMessage(
        'Notificaciones push',
      ),
      'quote': MessageLookupByLibrary.simpleMessage('Citar'),
      'quotePost': MessageLookupByLibrary.simpleMessage('Citar publicación'),
      'reachAPerson': MessageLookupByLibrary.simpleMessage(
        'Contactar a una persona',
      ),
      'remove': MessageLookupByLibrary.simpleMessage('Eliminar'),
      'removeMember': (Object memberName) => '¿Eliminar a $memberName?',
      'removeConversation': MessageLookupByLibrary.simpleMessage(
        '¿Eliminar esta conversación?',
      ),
      'removeMessage': MessageLookupByLibrary.simpleMessage(
        '¿Eliminar este mensaje?',
      ),
      'repliesFollowsMentions': MessageLookupByLibrary.simpleMessage(
        'Respuestas, seguimientos y menciones',
      ),
      'reply': MessageLookupByLibrary.simpleMessage('Responder'),
      'report': MessageLookupByLibrary.simpleMessage('Reportar'),
      'reportCopied': MessageLookupByLibrary.simpleMessage(
        'Informe copiado. Pégalo en un correo al soporte.',
      ),
      'reportSent': MessageLookupByLibrary.simpleMessage('Informe enviado'),
      'repost': MessageLookupByLibrary.simpleMessage('Republicar'),
      'reset': MessageLookupByLibrary.simpleMessage('Restablecer'),
      'resetPassword': MessageLookupByLibrary.simpleMessage(
        'Restablecer tu contraseña',
      ),
      'retry': MessageLookupByLibrary.simpleMessage('Reintentar'),
      'save': MessageLookupByLibrary.simpleMessage('Guardar'),
      'saveDraft': MessageLookupByLibrary.simpleMessage('Guardar borrador'),
      'saySomething': (Object communityName) => 'Di algo a $communityName',
      'searchByNameOrHandle': MessageLookupByLibrary.simpleMessage(
        'Buscar por nombre o usuario',
      ),
      'searchCommunities': MessageLookupByLibrary.simpleMessage(
        'Buscar comunidades',
      ),
      'searchGIFs': MessageLookupByLibrary.simpleMessage('Buscar GIFs'),
      'searchLanguages': MessageLookupByLibrary.simpleMessage('Buscar idiomas'),
      'searchTrendingTags': MessageLookupByLibrary.simpleMessage(
        'Buscar etiquetas tendencias',
      ),
      'securityAlerts': MessageLookupByLibrary.simpleMessage(
        'Alertas de seguridad y cambios en la cuenta',
      ),
      'sendConfirmation': MessageLookupByLibrary.simpleMessage(
        'Enviar confirmación',
      ),
      'sendErrorReport': MessageLookupByLibrary.simpleMessage(
        'Enviar informe de error',
      ),
      'sendFeedback':
          MessageLookupByLibrary.simpleMessage('Enviar comentarios'),
      'sendReport': MessageLookupByLibrary.simpleMessage('Enviar informe'),
      'sendToSupport':
          MessageLookupByLibrary.simpleMessage('Enviar al soporte'),
      'serviceStatus':
          MessageLookupByLibrary.simpleMessage('Estado del servicio'),
      'shareAppLog': MessageLookupByLibrary.simpleMessage(
        'Compartir el registro de la app con soporte',
      ),
      'signedInAs':
          MessageLookupByLibrary.simpleMessage('Iniciaste sesión como'),
      'signInToKyron': MessageLookupByLibrary.simpleMessage(
        'Iniciar sesión en Kyron',
      ),
      'signupFailed': (Object error) => 'Error al registrarse: $error',
      'stay': MessageLookupByLibrary.simpleMessage('Permanecer'),
      'systemLog': MessageLookupByLibrary.simpleMessage('Registro del sistema'),
      'tellMissingBroken': MessageLookupByLibrary.simpleMessage(
        'Cuéntanos qué falta o no funciona',
      ),
      'theComposerNoPostButton': MessageLookupByLibrary.simpleMessage(
        'El compositor no tiene botón de publicar',
      ),
      'translate': MessageLookupByLibrary.simpleMessage('Traduccir'),
      'tryAgain': MessageLookupByLibrary.simpleMessage('Intentar de nuevo'),
      'undoRepost':
          MessageLookupByLibrary.simpleMessage('Deshacer republicación'),
      'updatePassword': MessageLookupByLibrary.simpleMessage(
        'Actualizar contraseña',
      ),
      'useDifferentAddress': MessageLookupByLibrary.simpleMessage(
        'Usar otra dirección',
      ),
      'whatHappened': MessageLookupByLibrary.simpleMessage('¿Qué pasó?'),
      'whatHappenedAndLookAt': MessageLookupByLibrary.simpleMessage(
        '¿Qué pasó y qué debemos revisar?',
      ),
      'whatInPicture': MessageLookupByLibrary.simpleMessage(
        '¿Qué hay en esta imagen?',
      ),
      'whatIsItFor': MessageLookupByLibrary.simpleMessage(
        '¿Para qué es? (opcional)',
      ),
      'whatYouDid': MessageLookupByLibrary.simpleMessage(
        'Lo que hiciste, lo que esperabas, lo que pasó',
      ),
      'whatYouWereDoing': MessageLookupByLibrary.simpleMessage(
        'Lo que estabas haciendo cuando pasó.',
      ),
      'normalised': MessageLookupByLibrary.simpleMessage('#\\\$normalised'),
    };

final messageLookup = MessageLookup();
