Clase:04/07/2026

Instructor: Jesús Ariel Bonilla 

Tema: Registro de asistencias 

instrumentos de recolección 



\----------------------------------------------------------------

Problemática



Retraso en el registro de llamados de atención debido a un proceso manual.



\---------------------------------------------------------------



objetivo



Reducir tiempo de asistencia de los aprendices de la ficha 3413974



\------------------------------------------------------------------



instrumentos de recolección aplicado

&#x20;

Observación

\--------------------------------------------------------------------



requerimientos 



RF01.El sistema debe mostrar la lista de los aprendices automáticamente 



RF02. El sistema debe permitir registrar la asistencia de todos los aprendices desde una única pantalla, sin cambiar de ventana.



RF03. El sistema debe permitir asignar el estado de asistencia (Asistió, Tarde o Ausente) a cada aprendiz mediante un solo clic.



RF04. El sistema debe guardar el registro de asistencia de forma automática al finalizar el proceso de marcación.



RF05. El sistema debe permitir consultar los registros de asistencia por ficha y fecha mediante un filtro de búsqueda.



RF06. El sistema debe generar un reporte de asistencia de la ficha seleccionada para la fecha consultada.



\------------------------------------------------------------------------------



DIAGRAMA DE CASOS DE USO - MÓDULO DE ASISTENCIA



&#x20;                             Instructor

&#x20;                                 |

&#x20;                                 |

&#x20;                       (Registrar asistencia)

&#x20;                             /        \\

&#x20;                     <<include>>   <<include>>

&#x20;                         /              \\

&#x20;             (Ver aprendices)      (Asignar estado)

&#x20;                   RF01                   |

&#x20;                                     <<include>>

&#x20;                                          |

&#x20;                                  (Guardar registro)

&#x20;                                        RF04





Instructor ----------------> (Consultar asistencia)

&#x20;                                         |

&#x20;                                   <<include>>

&#x20;                                         |

&#x20;                                 (Generar reporte)

&#x20;                                       RF06







