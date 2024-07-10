﻿using ApiBanca.Controllers.Interfaces;
using Aplicacion.Caracteristicas.RegistroCivil;
using Aplicacion.Caracteristicas.Usuario;
using Aplicacion.Helper.Comunes;
using Microsoft.AspNetCore.Mvc;

namespace ApiBanca.Controllers
{
    public class RegistroCivilController : ApiBaseController
    {
        [HttpPost("validar-cedula")]
        public async Task<ActionResult> ValidarCedula(ValidarCedula.Comando request)
        {
            try
            {
                var resultado = await Mediator.Send(request);
                return Ok(resultado);
            }
            catch (ExcepcionValidacion error)
            {
                return BadRequest(new { Mensaje = error.Message, error.Errors });
            }
            catch (Exception error){
                return BadRequest(new { Mensaje = error.Message });}
        }
        // AQUI VA LA VALIDACION DE ROSTRO rmarco
         [HttpPost("validar-rostro")]
        public async Task<ActionResult> ValidarRostro(ValidarRostro.DatosValidarRostro request)
        {
            try
            {
                var resultado = await Mediator.Send(new ValidarRostro.Comando(request));
                return Ok(resultado);
            }
            catch (ExcepcionValidacion error)
            {
                return BadRequest(new { Mensaje = error.Message, error.Errors });
            }
            catch (Exception error)
            {
                return BadRequest(new { Mensaje = error.Message });
            }
        }
    }
}
