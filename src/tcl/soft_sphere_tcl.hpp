/*
  Copyright (C) 2010,2011,2012,2013 The ESPResSo project
  Copyright (C) 2002,2003,2004,2005,2006,2007,2008,2009,2010 
    Max-Planck-Institute for Polymer Research, Theory Group
  
  This file is part of ESPResSo.
  
  ESPResSo is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  
  ESPResSo is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  
  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>. 
*/
#ifndef SOFT_SPHERE_TCL_H
#define SOFT_SPHERE_TCL_H
/** \file soft_sphere_tcl.hpp
 * Tcl interface for \ref soft_sphere.h
 */

#include "parser.hpp"

#ifdef SOFT_SPHERE

///
int tclprint_to_result_softIA(Tcl_Interp *interp, int i, int j);

///
int tclcommand_inter_parse_soft(Tcl_Interp * interp,
				int part_type_a, int part_type_b,
				int argc, char ** argv);

#endif

#endif
